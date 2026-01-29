# Regulamentação Brasileira - Fintech para Menores

## Sumário Executivo

Para operar uma fintech de contas para menores no Brasil, existem duas opções principais:

1. **Parceria com IP/Banco licenciado** (recomendado para MVP)
2. **Licença própria de IP** (longo prazo)

---

## 1. Banco Central do Brasil (Bacen)

### 1.1 Tipos de Instituição

| Tipo | Capital Mínimo | Tempo Aprovação | Pode Emitir Cartão |
|------|----------------|-----------------|-------------------|
| **IP Emissora de Moeda Eletrônica** | R$ 2 milhões | 12-24 meses | ✅ |
| **IP Pós-paga** | R$ 2 milhões | 12-24 meses | ✅ |
| **Banco Digital (SCD)** | R$ 8 milhões | 18-36 meses | ✅ |
| **Parceria com IP existente** | Zero | Imediato | ✅ (via parceiro) |

### 1.2 Parceiros BaaS (Banking as a Service)

| Parceiro | Serviços | Observações |
|----------|----------|-------------|
| **Dock** | Conta, cartão, PIX | Maior do Brasil |
| **Pismo** | Core banking, cartões | Usado pela Nubank |
| **Matera** | Conta, PIX, boleto | Foco em PIX |
| **Zoop** | Pagamentos | Stone/Linx |
| **Celcoin** | Conta, PIX | Infraestrutura |

**Recomendação MVP:** Iniciar com parceria BaaS (Dock ou Matera)

---

## 2. Contas para Menores de Idade

### 2.1 Requisitos Legais

| Aspecto | Regra | Base Legal |
|---------|-------|------------|
| **Representação** | Menor deve ser representado por pai/mãe/tutor | Código Civil Art. 1.634 |
| **CPF** | Obrigatório para abertura de conta | Normativa Receita Federal |
| **Idade mínima** | Não há (depende da instituição) | Prática de mercado: 6+ anos |
| **Documentação** | RG/CNH do responsável + certidão do menor | Bacen |

### 2.2 Limites por Faixa Etária (Sugestão)

| Idade | PIX Diário | Cartão Diário | PIX Noturno | Observações |
|-------|------------|---------------|-------------|-------------|
| 6-11 | R$ 100 | R$ 100 | R$ 50 | Sem PIX para terceiros |
| 12-15 | R$ 500 | R$ 300 | R$ 200 | PIX só para contatos aprovados |
| 16-17 | R$ 1.000 | R$ 500 | R$ 300 | PIX completo |

---

## 3. PIX para Menores

### 3.1 Regras do Bacen

- **Não há idade mínima** para usar PIX
- Menor pode ter chave PIX **vinculada à conta**
- **Supervisão parental** é requisito da instituição
- Limites de horário noturno (22h-6h) se aplicam

### 3.2 Tipos de Chave

| Tipo | Permitido para Menor | Observação |
|------|---------------------|------------|
| CPF | ✅ | Recomendado |
| Celular | ✅ | Se tiver celular próprio |
| Email | ✅ | Se tiver email próprio |
| Aleatória | ✅ | Gerada pelo sistema |

---

## 4. LGPD - Proteção de Dados de Menores

### 4.1 Requisitos Específicos

| Requisito | Obrigação | Como Implementar |
|-----------|-----------|------------------|
| **Consentimento** | Parental obrigatório | Aceite no app do pai |
| **Minimização** | Coletar só o necessário | Campos mínimos no cadastro |
| **Transparência** | Linguagem clara | Termos simplificados |
| **Portabilidade** | Exportar dados | Botão no app |
| **Exclusão** | Direito ao esquecimento | Processo documentado |
| **DPO** | Encarregado nomeado | Contato público |

### 4.2 Dados Sensíveis de Menores

```
COLETAR (necessário):
✅ Nome completo
✅ CPF
✅ Data de nascimento
✅ Foto (selfie para KYC)

NÃO COLETAR (desnecessário):
❌ Geolocalização contínua (só com opt-in)
❌ Dados de navegação
❌ Contatos do celular
❌ Dados biométricos além de facial
```

### 4.3 Relatório de Impacto (RIPD)

Obrigatório elaborar RIPD contendo:
- Descrição do tratamento
- Necessidade e proporcionalidade
- Riscos identificados
- Medidas de mitigação

---

## 5. PLD/FT - Prevenção à Lavagem de Dinheiro

### 5.1 Obrigações

| Obrigação | Descrição | Frequência |
|-----------|-----------|------------|
| **KYC** | Conhecer o cliente (pai e filho) | Abertura |
| **Monitoramento** | Transações suspeitas | Contínuo |
| **Comunicação** | Reportar ao COAF | Quando aplicável |
| **Treinamento** | Equipe capacitada | Anual |

### 5.2 Limites de Alerta (Sugestão)

| Transação | Valor Alerta | Ação |
|-----------|--------------|------|
| PIX único | > R$ 1.000 | Revisar |
| PIX diário | > R$ 3.000 | Bloquear + revisar |
| Cartão único | > R$ 500 | Notificar pai |
| Recarga mensal | > R$ 5.000 | KYC reforçado |

---

## 6. Investimentos para Menores

### 6.1 Produtos Permitidos

| Produto | Permitido | Requisitos |
|---------|-----------|------------|
| **Poupança** | ✅ | Conta em nome do menor |
| **CDB** | ✅ | Autorização parental |
| **Tesouro Direto** | ✅ | CPF do menor |
| **Fundos** | ✅ | Termo de responsabilidade |
| **Ações** | ⚠️ | Conta especial, responsável como mandatário |
| **Cripto** | ❌ | Não regulamentado para menores |

### 6.2 Tributação

- **Poupança**: Isenta
- **CDB/Tesouro**: IR regressivo (22.5% a 15%)
- **Fundos**: Come-cotas semestral
- **Ações**: 15% sobre ganho de capital

---

## 7. Checklist de Compliance

### 7.1 Antes do Lançamento

- [ ] Parceria com IP/BaaS formalizada
- [ ] Termos de uso aprovados por jurídico
- [ ] Política de privacidade (LGPD)
- [ ] RIPD elaborado
- [ ] DPO nomeado
- [ ] Processo de KYC implementado
- [ ] Sistema de monitoramento PLD
- [ ] Treinamento da equipe
- [ ] Pentest realizado
- [ ] Backup e DR testados

### 7.2 Operação Contínua

- [ ] Monitoramento de transações (diário)
- [ ] Revisão de alertas PLD (semanal)
- [ ] Atualização de políticas (trimestral)
- [ ] Auditoria interna (semestral)
- [ ] Pentest (anual)
- [ ] Treinamento PLD (anual)

---

## 8. Custos Regulatórios Estimados

| Item | Custo Estimado | Frequência |
|------|----------------|------------|
| **Consultoria jurídica** | R$ 30-50k | Setup |
| **Elaboração RIPD** | R$ 10-20k | Setup |
| **Parceria BaaS** | 1-3% da receita | Mensal |
| **Pentest** | R$ 15-30k | Anual |
| **Auditoria** | R$ 20-40k | Anual |
| **Treinamento PLD** | R$ 5-10k | Anual |
| **DPO (terceirizado)** | R$ 3-5k | Mensal |

**Total estimado (Ano 1):** R$ 100-150k

---

## Referências

- [Bacen - Instituições de Pagamento](https://www.bcb.gov.br/estabilidadefinanceira/instituicoespagamento)
- [Lei 13.709/2018 - LGPD](http://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm)
- [Circular Bacen 3.978/2020 - PLD/FT](https://www.bcb.gov.br/estabilidadefinanceira/exibenormativo?tipo=Circular&numero=3978)
- [CVM - Investimentos para Menores](https://www.gov.br/cvm/pt-br)
