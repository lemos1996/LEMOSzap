import os
import json
import datetime
import subprocess
import threading
import webbrowser
from flask import Flask, render_template, request, jsonify, redirect, url_for

app = Flask(__name__)

# Configurações de Caminhos
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
SERVER_DIR = os.path.join(BASE_DIR, "server")
DB_FILE = os.path.join(SERVER_DIR, "clientes.json")
EXTENSION_DIR = os.path.join(BASE_DIR, "extension")

# Variável para controlar o processo do servidor da extensão
extension_server_process = None

def load_db():
    if not os.path.exists(DB_FILE):
        return {}
    try:
        with open(DB_FILE, 'r', encoding='utf-8') as f:
            return json.load(f)
    except:
        return {}

def save_db(db):
    with open(DB_FILE, 'w', encoding='utf-8') as f:
        json.dump(db, f, indent=4, ensure_ascii=False)

@app.route('/')
def index():
    db = load_db()
    # Preparar lista de clientes para o template
    clientes = []
    for ws, info in db.items():
        dados = info.get('dados', {})
        clientes.append({
            'whatsapp': ws,
            'nome': dados.get('nome', 'Sem Nome'),
            'licenca': dados.get('licenca', 'ATIVA'),
            'premium': dados.get('Premium ativa', 'não'),
            'expira_em': dados.get('expira_em', '-')
        })
    
    server_running = extension_server_process is not None and extension_server_process.poll() is None
    return render_template('index.html', clientes=clientes, server_running=server_running)

@app.route('/api/licenca/salvar', methods=['POST'])
def salvar_licenca():
    data = request.json
    whatsapp = data.get('whatsapp')
    if not whatsapp:
        return jsonify({"status": "error", "message": "WhatsApp é obrigatário"}), 400
    
    db = load_db()
    db[whatsapp] = {
        "data_registro": datetime.datetime.now().isoformat(),
        "ultima_atualizacao": datetime.datetime.now().isoformat(),
        "dados": {
            "nome": data.get('nome', 'Cliente'),
            "whatsapp": whatsapp,
            "licenca": "ATIVA",
            "Premium ativa": data.get('premium', 'sim'),
            "expira_em": data.get('expira_em', '2027-01-30')
        },
        "status": "ativo"
    }
    save_db(db)
    return jsonify({"status": "success"})

@app.route('/api/licenca/deletar/<whatsapp>', methods=['DELETE'])
def deletar_licenca(whatsapp):
    db = load_db()
    if whatsapp in db:
        del db[whatsapp]
        save_db(db)
        return jsonify({"status": "success"})
    return jsonify({"status": "error", "message": "Não encontrado"}), 404

@app.route('/api/servidor/status')
def server_status():
    global extension_server_process
    is_running = extension_server_process is not None and extension_server_process.poll() is None
    return jsonify({"running": is_running})

@app.route('/api/servidor/toggle', methods=['POST'])
def toggle_server():
    global extension_server_process
    
    is_running = extension_server_process is not None and extension_server_process.poll() is None
    
    if is_running:
        # Parar
        extension_server_process.terminate()
        extension_server_process = None
        return jsonify({"status": "stopped"})
    else:
        # Iniciar
        try:
            # Caminho para o script server.py
            server_script = os.path.join(SERVER_DIR, "server.py")
            # Iniciar em processo separado
            extension_server_process = subprocess.Popen(["python", server_script], cwd=SERVER_DIR)
            return jsonify({"status": "started"})
        except Exception as e:
            return jsonify({"status": "error", "message": str(e)}), 500

@app.route('/api/github/sync', methods=['POST'])
def github_sync():
    data = request.json
    msg = data.get('message', 'Update via Painel Mestre')
    
    git_path = r"C:\Program Files\Git\cmd\git.exe"
    if not os.path.exists(git_path):
        git_path = "git" # Fallback para o padrão se não encontrar no C:

    try:
        # Comandos Git
        subprocess.run([git_path, "add", "."], cwd=BASE_DIR, check=True)
        subprocess.run([git_path, "commit", "-m", msg], cwd=BASE_DIR, check=True)
        subprocess.run([git_path, "push", "origin", "main"], cwd=BASE_DIR, check=True)
        return jsonify({"status": "success"})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

def open_browser():
    webbrowser.open_new("http://127.0.0.1:5001")

if __name__ == '__main__':
    # Criar pasta templates se não existir
    if not os.path.exists(os.path.join(BASE_DIR, "templates")):
        os.makedirs(os.path.join(BASE_DIR, "templates"))
        
    print("====================================================")
    print("   PAINEL DE CONTROLE LEMOSZAP INICIANDO...   ")
    print("====================================================")
    
    # Abrir o navegador após um pequeno delay
    threading.Timer(1.5, open_browser).start()
    
    app.run(port=5001, debug=False)
