# 🚀 LEMOSzap Extension

Extensão Chrome/Edge para WhatsApp Web com funcionalidades avançadas de CRM, automação e gestão de conversas.

## ✨ Funcionalidades

### 📊 CRM Completo
- Gestão de contatos e conversas
- Categorização por etiquetas personalizadas
- Notas e histórico de interações
- Funil de vendas visual

### ⚡ Automação
- **Respostas Rápidas**: Mensagens pré-definidas com suporte a mídia
- **Agendamento**: Agende mensagens para envio futuro
- **Fluxos**: Automação de sequências de mensagens
- **Follow-up**: Acompanhamento automático de clientes

### 🤖 Inteligração com IA
- Suporte para Gemini, GPT e Groq
- Respostas inteligentes
- Análise de conversas

### 📈 Gestão
- Multi-atendimento
- Relatórios e estatísticas
- Backup automático
- Webhooks para integração

## 🔧 Instalação

### Método 1: Instalação Manual (Desenvolvedor)

1. Clone este repositório:
```bash
git clone https://github.com/SEU_USUARIO/LEMOSzap-extension.git
```

2. Abra o Chrome/Edge e acesse:
   - Chrome: `chrome://extensions/`
   - Edge: `edge://extensions/`

3. Ative o **Modo do desenvolvedor**

4. Clique em **Carregar sem compactação**

5. Selecione a pasta do projeto

### Método 2: Instalação via Chrome Web Store
*(Em breve)*

## ⚙️ Configuração

### Conexão com o Servidor de Licenças

A extensão se conecta automaticamente ao servidor de licenças. Para usar um servidor local:

1. Edite o arquivo `background.js`
2. Localize a seção de configuração:
```javascript
const w = {
  backend_plugin: "http://localhost:5000/",
  // ... outras configurações
};
```

### Sistema de Licenças

A extensão valida a licença no formato:
```json
{
  "whatsapp": "551199999999",
  "licenca": "ATIVA",
  "expira_em": "2026-01-30"
}
```

**Status de licença:**
- `ATIVA` - Todas as funcionalidades liberadas
- `EXPIRADA` - Acesso limitado
- `BLOQUEADA` - Sem acesso

## 📁 Estrutura do Projeto

```
LEMOSzap-extension/
├── manifest.json          # Configuração da extensão
├── background.js          # Service worker principal
├── content.css           # Estilos injetados
├── assets/               # Recursos (imagens, ícones)
├── content/              # Scripts de conteúdo
├── crm/                  # Módulo CRM
├── fluxo/                # Módulo de fluxos
├── funnil/               # Módulo funil de vendas
├── label/                # Sistema de etiquetas
└── whatsapp/             # Integração WhatsApp
```

## 🔐 Permissões

A extensão requer as seguintes permissões:
- `storage` - Armazenamento local de dados
- `unlimitedStorage` - Armazenamento ilimitado
- `alarms` - Agendamentos e notificações
- `tabs` - Gerenciamento de abas

## 🛠️ Desenvolvimento

### Pré-requisitos
- Node.js 16+ (opcional, para build)
- Chrome/Edge atualizado

### Estrutura de Dados

Os dados são armazenados localmente usando `chrome.storage.local`:
- `respostasRapidas` - Mensagens rápidas
- `agendamentos` - Mensagens agendadas
- `crm` - Dados do CRM
- `contatos` - Lista de contatos
- `fluxo` - Fluxos de automação
- `notifications` - Notificações

## 🐛 Debug

Para visualizar logs:
1. Abra o DevTools (F12)
2. Vá para a aba Console
3. Filtre por "lemoszap" ou "LEMOSzap"

## 📝 Changelog

### v7.4.3.6 (Atual)
- Sistema de licenças integrado
- Melhorias no CRM
- Novos fluxos de automação
- Correções de bugs

## 🤝 Contribuindo

Este é um projeto proprietário. Contribuições são aceitas mediante aprovação.

## 📄 Licença

Propriedade de LEMOS - Todos os direitos reservados.

## 📞 Suporte

Para suporte, entre em contato através do WhatsApp registrado na licença.

---

Desenvolvido com ❤️ por LEMOS
