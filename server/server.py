from flask import Flask, request, jsonify, make_response
from flask_cors import CORS
import logging
import json
import datetime

# Configuração de Logs
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger('MockServer')

app = Flask(__name__)
# Habilitar CORS para todas as origens, pois a extensão roda em contexto de extensão
CORS(app, resources={r"/*": {"origins": "*"}})

@app.before_request
def log_request_info():
    """Loga todas as requisições para análise"""
    logger.info(f"Headers: {dict(request.headers)}")
    if request.is_json:
        logger.info(f"Body: {request.get_json()}")
    else:
        logger.info(f"Body Raw: {request.data}")

# --- Rota Curinga para Capturar Tudo ---
@app.route('/', defaults={'path': ''}, methods=['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'])
@app.route('/<path:path>', methods=['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'])
def catch_all(path):
    logger.warning(f"Rota não implementada acessada: /{path}")
    
    # Resposta genérica para evitar erros de rede pendentes
    return jsonify({
        "status": "success",
        "message": "Interceptado pelo Mock Server",
        "path": path,
        "data": {}
    }), 200

# --- Rotas Específicas Simuladas ---

@app.route('/api/modelosCRM/get', methods=['GET'])
def get_modelos_crm():
    logger.info("Retornando Lista de Modelos CRM Falsa")
    return jsonify({
        "data": {
            "modelos": [
                {
                    "id": 1,
                    "nome": "Padrão (Servidor Local)",
                    "arquivo": json.dumps({
                        "categoria": [{"id": 1, "nome": "Novos", "cor": "#FF0000"}],
                        "guardaMsg": [],
                        "medias": []
                    })
                },
                {
                    "id": 2,
                    "nome": "Vendas (Exemplo)",
                    "arquivo": json.dumps({
                        "categoria": [{"id": 2, "nome": "Em Negociação", "cor": "#00FF00"}],
                        "guardaMsg": [],
                        "medias": []
                    })
                }
            ]
        }
    })

@app.route('/api/clientesRegistrados/set', methods=['POST'])
def register_client():
    data = request.get_json()
    logger.info(f"Registrando cliente: {data.get('whatsapp')}")
    
    # Persistência Simples (Banco de Dados em Arquivo)
    db_file = 'clientes.json'
    try:
        try:
            with open(db_file, 'r') as f:
                clients = json.load(f)
        except (FileNotFoundError, json.JSONDecodeError):
            clients = {}

        # Usa o whatsapp como chave única
        user_id = data.get('whatsapp', 'desconhecido')
        clients[user_id] = {
            "data_registro": datetime.datetime.now().isoformat(),
            "dados": data,
            "status": "ativo"  # Aqui você poderia bloquear o usuário mudando para "bloqueado"
        }
        
        with open(db_file, 'w') as f:
            json.dump(clients, f, indent=4)
            
        logger.info(f"Cliente {user_id} salvo com sucesso.")
    except Exception as e:
        logger.error(f"Erro ao salvar cliente: {e}")

    return jsonify({
        "status": "success", 
        "message": "Registrado com sucesso no servidor LEMOS"
    })

if __name__ == '__main__':
    print("====================================================")
    print("   SERVIDOR WATSWATS (MOCK) RODANDO NA PORTA 5000   ")
    print("====================================================")
    print("Aguardando requisições da extensão...")
    # Rodar em 0.0.0.0 para garantir acesso, debug mode on para reload
    app.run(debug=True, host='0.0.0.0', port=5000)
