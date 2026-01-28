# 🔐 LEMOSzap Server

Servidor backend em Python/Flask para controle de licenças, validação de usuários e sincronização de dados da extensão LEMOSzap.

## ✨ Funcionalidades

- ✅ **Sistema de Licenças**: Controle de acesso e validação
- ✅ **Registro de Clientes**: Cadastro e gestão de usuários
- ✅ **Modelos de CRM**: Sincronização de templates
- ✅ **API REST**: Endpoints para integração
- ✅ **Logs Detalhados**: Monitoramento de requisições
- ✅ **CORS Habilitado**: Acesso de extensões Chrome

## 🚀 Instalação

### Pré-requisitos
- Python 3.8 ou superior
- pip (gerenciador de pacotes Python)

### Passo a Passo

1. Clone o repositório:
```bash
git clone https://github.com/SEU_USUARIO/LEMOSzap-server.git
cd LEMOSzap-server
```

2. Crie um ambiente virtual (recomendado):
```bash
python -m venv venv

# Windows
venv\Scripts\activate

# Linux/Mac
source venv/bin/activate
```

3. Instale as dependências:
```bash
pip install -r requirements.txt
```

4. Execute o servidor:
```bash
python server.py
```

O servidor estará rodando em `http://localhost:5000`

## 📡 API Endpoints

### 1. Registrar Cliente
**POST** `/api/clientesRegistrados/set`

Registra um novo cliente no sistema.

**Request Body:**
```json
{
  "whatsapp": "551199999999",
  "licenca": "ATIVA",
  "expira_em": "2026-01-30"
}
```

**Response:**
```json
{
  "status": "success",
  "message": "Registrado com sucesso no servidor LEMOS"
}
```

### 2. Obter Modelos CRM
**GET** `/api/modelosCRM/get`

Retorna os modelos de CRM disponíveis.

**Response:**
```json
{
  "data": {
    "modelos": [
      {
        "id": 1,
        "nome": "Padrão (Servidor Local)",
        "arquivo": "{...}"
      }
    ]
  }
}
```

### 3. Validar Licença
**GET** `/api/licenca/validar?whatsapp=551199999999`

Valida se a licença está ativa.

**Response:**
```json
{
  "whatsapp": "551199999999",
  "licenca": "ATIVA",
  "expira_em": "2026-01-30",
  "dias_restantes": 2
}
```

## 📊 Formato de Licença

Cada cliente possui uma licença no formato:

```json
{
  "whatsapp": "551199999999",
  "licenca": "ATIVA",
  "expira_em": "2026-01-30"
}
```

### Status de Licença
- **ATIVA**: Todas as funcionalidades liberadas
- **EXPIRADA**: Licença vencida, acesso limitado
- **BLOQUEADA**: Acesso negado
- **TRIAL**: Período de teste (7 dias)

## 🗄️ Banco de Dados

Atualmente usa arquivo JSON (`clientes.json`) para persistência.

**Estrutura:**
```json
{
  "551199999999": {
    "data_registro": "2026-01-28T19:00:00",
    "dados": {
      "whatsapp": "551199999999",
      "licenca": "ATIVA",
      "expira_em": "2026-01-30"
    },
    "status": "ativo"
  }
}
```

### Migração para Banco SQL (Futuro)
O sistema está preparado para migração para PostgreSQL/MySQL/SQLite.

## ⚙️ Configuração

### Variáveis de Ambiente

Crie um arquivo `.env` na raiz do projeto:

```env
# Servidor
HOST=0.0.0.0
PORT=5000
DEBUG=True

# Segurança
SECRET_KEY=sua-chave-secreta-aqui

# Banco de Dados (futuro)
DATABASE_URL=sqlite:///lemoszap.db
```

### Configuração de CORS

Por padrão, o CORS está habilitado para todas as origens. Para produção, edite `server.py`:

```python
CORS(app, resources={r"/*": {"origins": ["chrome-extension://SEU_ID_AQUI"]}})
```

## 🔒 Segurança

### Recomendações para Produção:

1. **Use HTTPS**: Configure SSL/TLS
2. **Autenticação**: Implemente tokens JWT
3. **Rate Limiting**: Limite requisições por IP
4. **Validação**: Valide todos os inputs
5. **Logs**: Monitore acessos suspeitos

## 📁 Estrutura do Projeto

```
LEMOSzap-server/
├── server.py              # Aplicação Flask principal
├── requirements.txt       # Dependências Python
├── clientes.json         # Banco de dados (gerado automaticamente)
├── .env                  # Variáveis de ambiente (criar)
├── .gitignore           # Arquivos ignorados pelo Git
└── README.md            # Este arquivo
```

## 🛠️ Desenvolvimento

### Adicionar Novo Endpoint

```python
@app.route('/api/seu-endpoint', methods=['POST'])
def seu_endpoint():
    data = request.get_json()
    # Sua lógica aqui
    return jsonify({"status": "success"})
```

### Logs

Os logs são exibidos no console com o formato:
```
2026-01-28 19:00:00 - INFO - Mensagem
```

## 🐛 Troubleshooting

### Erro: "Address already in use"
A porta 5000 já está em uso. Altere a porta em `server.py`:
```python
app.run(debug=True, host='0.0.0.0', port=5001)
```

### Erro: "Module not found"
Instale as dependências:
```bash
pip install -r requirements.txt
```

## 📝 TODO

- [ ] Implementar autenticação JWT
- [ ] Migrar para banco SQL
- [ ] Adicionar painel de administração web
- [ ] Implementar sistema de planos (Free, Pro, Enterprise)
- [ ] Adicionar webhooks para eventos
- [ ] Criar dashboard de estatísticas
- [ ] Implementar backup automático

## 📄 Licença

Propriedade de LEMOS - Todos os direitos reservados.

## 📞 Suporte

Para suporte técnico, entre em contato através do WhatsApp cadastrado.

---

Desenvolvido com ❤️ por LEMOS
