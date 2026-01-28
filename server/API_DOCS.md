# 📚 Documentação da API - LEMOSzap Server

## Base URL
```
http://localhost:5000
```

## Formato de Licença

Todas as licenças seguem o formato:

```json
{
  "nome": "João Silva",
  "whatsapp": "551199999999",
  "licenca": "ATIVA",
  "expira_em": "2026-01-30"
}
```

### Campos

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| `nome` | string | Sim | Nome do cliente |
| `whatsapp` | string | Sim | Número do WhatsApp (com DDI) |
| `licenca` | string | Sim | Status da licença |
| `expira_em` | string | Não | Data de expiração (YYYY-MM-DD) |

### Status de Licença

| Status | Descrição |
|--------|-----------|
| `ATIVA` | Licença ativa, todas as funcionalidades liberadas |
| `TRIAL` | Período de teste (padrão para novos clientes) |
| `EXPIRADA` | Licença vencida, acesso limitado |
| `BLOQUEADA` | Acesso negado |

---

## Endpoints

### 1. Health Check

Verifica se o servidor está online.

**Endpoint:** `GET /health`

**Response:**
```json
{
  "status": "online",
  "timestamp": "2026-01-28T19:00:00",
  "version": "1.0.0"
}
```

---

### 2. Validar Licença

Valida se a licença de um cliente está ativa.

**Endpoint:** `GET /api/licenca/validar?whatsapp=551199999999`

**Parâmetros:**
- `whatsapp` (query string) - Número do WhatsApp

**Response (Sucesso):**
```json
{
  "status": "success",
  "whatsapp": "551199999999",
  "licenca": "ATIVA",
  "expira_em": "2026-01-30",
  "dias_restantes": 2
}
```

**Response (Expirada):**
```json
{
  "status": "success",
  "whatsapp": "551199999999",
  "licenca": "EXPIRADA",
  "expira_em": "2026-01-26",
  "dias_restantes": -2
}
```

**Response (Não encontrado):**
```json
{
  "status": "error",
  "message": "Cliente não encontrado",
  "licenca": "BLOQUEADA"
}
```

---

### 3. Registrar Cliente

Registra um novo cliente ou atualiza dados existentes.

**Endpoint:** `POST /api/clientesRegistrados/set`

**Request Body:**
```json
{
  "nome": "João Silva",
  "whatsapp": "551199999999",
  "licenca": "ATIVA",
  "expira_em": "2026-01-30"
}
```

**Response:**
```json
{
  "status": "success",
  "message": "Cliente registrado com sucesso no servidor LEMOS",
  "dados": {
    "nome": "João Silva",
    "whatsapp": "551199999999",
    "licenca": "ATIVA",
    "expira_em": "2026-01-30"
  }
}
```

---

### 4. Listar Clientes

Lista todos os clientes registrados (endpoint administrativo).

**Endpoint:** `GET /api/clientesRegistrados/get`

**Response:**
```json
{
  "status": "success",
  "total": 2,
  "clientes": [
    {
      "nome": "João Silva",
      "whatsapp": "551199999999",
      "licenca": "ATIVA",
      "expira_em": "2026-01-30",
      "data_registro": "2026-01-28T18:00:00"
    },
    {
      "nome": "Maria Santos",
      "whatsapp": "551188888888",
      "licenca": "TRIAL",
      "expira_em": "2026-02-05",
      "data_registro": "2026-01-28T19:00:00"
    }
  ]
}
```

---

### 5. Atualizar Licença

Atualiza o status da licença de um cliente.

**Endpoint:** `POST /api/licenca/atualizar`

**Request Body:**
```json
{
  "whatsapp": "551199999999",
  "licenca": "ATIVA",
  "expira_em": "2026-02-28"
}
```

**Response:**
```json
{
  "status": "success",
  "message": "Licença atualizada com sucesso",
  "dados": {
    "nome": "João Silva",
    "whatsapp": "551199999999",
    "licenca": "ATIVA",
    "expira_em": "2026-02-28"
  }
}
```

---

### 6. Obter Modelos CRM

Retorna modelos de CRM pré-configurados.

**Endpoint:** `GET /api/modelosCRM/get`

**Response:**
```json
{
  "data": {
    "modelos": [
      {
        "id": 1,
        "nome": "Padrão (Servidor Local)",
        "arquivo": "{\"categoria\":[{\"id\":1,\"nome\":\"Novos\",\"cor\":\"#FF6B6B\"}]}"
      },
      {
        "id": 2,
        "nome": "Vendas (Exemplo)",
        "arquivo": "{\"categoria\":[{\"id\":1,\"nome\":\"Lead\",\"cor\":\"#FFA07A\"}]}"
      }
    ]
  }
}
```

---

## Exemplos de Uso

### cURL

**Registrar um cliente:**
```bash
curl -X POST http://localhost:5000/api/clientesRegistrados/set \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "João Silva",
    "whatsapp": "551199999999",
    "licenca": "ATIVA",
    "expira_em": "2026-01-30"
  }'
```

**Validar licença:**
```bash
curl http://localhost:5000/api/licenca/validar?whatsapp=551199999999
```

### JavaScript (Fetch)

```javascript
// Registrar cliente
fetch('http://localhost:5000/api/clientesRegistrados/set', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    nome: "João Silva",
    whatsapp: "551199999999",
    licenca: "ATIVA",
    expira_em: "2026-01-30"
  })
})
.then(response => response.json())
.then(data => console.log(data));

// Validar licença
fetch('http://localhost:5000/api/licenca/validar?whatsapp=551199999999')
  .then(response => response.json())
  .then(data => console.log(data));
```

### Python (Requests)

```python
import requests

# Registrar cliente
response = requests.post('http://localhost:5000/api/clientesRegistrados/set', json={
    "nome": "João Silva",
    "whatsapp": "551199999999",
    "licenca": "ATIVA",
    "expira_em": "2026-01-30"
})
print(response.json())

# Validar licença
response = requests.get('http://localhost:5000/api/licenca/validar', params={
    "whatsapp": "551199999999"
})
print(response.json())
```

---

## Códigos de Status HTTP

| Código | Significado |
|--------|-------------|
| 200 | Sucesso |
| 400 | Requisição inválida |
| 404 | Recurso não encontrado |
| 500 | Erro interno do servidor |

---

## Estrutura do Banco de Dados (JSON)

O arquivo `clientes.json` tem a seguinte estrutura:

```json
{
  "551199999999": {
    "data_registro": "2026-01-28T18:00:00",
    "ultima_atualizacao": "2026-01-28T19:00:00",
    "dados": {
      "nome": "João Silva",
      "whatsapp": "551199999999",
      "licenca": "ATIVA",
      "expira_em": "2026-01-30"
    },
    "status": "ativo"
  }
}
```

---

## Notas Importantes

1. **Validação Automática**: O servidor verifica automaticamente se a licença expirou ao validar
2. **CORS**: Habilitado para todas as origens (ajustar em produção)
3. **Logs**: Todas as requisições são logadas no console
4. **Persistência**: Dados salvos em arquivo JSON (migrar para SQL em produção)

---

Desenvolvido com ❤️ por LEMOS
