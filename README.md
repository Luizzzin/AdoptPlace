# Adopt Place

## Integrantes:

|             **NOME**            | **RM** | **TURMA** |              **RESPONSABILIDADES**             |
|:-------------------------------:|:------:|:---------:|:----------------------------------------------:|
|    Luiz Henrique Barbosa Dias   | 562399 |   2CCPO   |   (Responsavel pelo banco de dados e conexão)  |
|      Gregory Debom Ferreira     | 562346 |   2CCPO   |          (Idealizador e design figma)          |
| Rodrigo Kenshin Viana Matayoshi | 564026 |   2CCPH   | (Responsavel por Auxiliar as tarefas em geral) |

---

### Oque este app resolve?

A adoção de animais no Brasil ainda enfrenta um problema estrutural de **visibilidade e organização**: ONGs e protetores independentes divulgam pets disponíveis para adoção de forma pulverizada — em posts soltos no Instagram, grupos de WhatsApp, stories que somem em 24h — o que dificulta tanto o alcance das ONGs quanto a busca de quem realmente quer adotar.

Do lado de quem quer adotar, a experiência também é fragmentada: não existe um lugar único para navegar entre pets disponíveis, comparar características, e demonstrar interesse de forma direta. Isso empurra muitas pessoas para a compra de animais em pet shops ou canis, simplesmente porque é mais fácil e centralizado do que o processo de adoção.

O **Adopt Place** resolve esse problema centralizando, em um só lugar, a divulgação feita por ONGs e a busca por parte de adotantes — reduzindo o atrito em ambas as pontas e incentivando a adoção responsável como alternativa real à compra.

### Publico alvo:

- **ONGs e protetores independentes de animais**, que precisam de um canal centralizado e eficiente para divulgar pets disponíveis para adoção, sem depender exclusivamente de redes sociais genéricas.
- **Pessoas interessadas em adotar um pet**, que buscam praticidade para descobrir animais disponíveis na sua região, comparar características e iniciar o processo de interesse de forma simples — no lugar de recorrer à compra por conveniência.

### Principais funcionalidades

- **Feed estilo vitrine/rede social**: navegação por cards de pets disponíveis, com foto, nome, idade, espécie/raça e situação atual (ex: resgatado, em lar temporário, disponível para adoção).
- **Perfil detalhado do pet**: informações complementares como temperamento, estado de saúde, histórico e ONG responsável.
- **Demonstração de interesse**: usuário pode manifestar interesse em um pet diretamente pelo app, iniciando contato com a ONG responsável.
- **Perfil de ONGs**: cadastro e gerenciamento dos pets disponíveis, com upload de fotos e atualização de status (disponível, em processo, adotado).
- **Filtros de busca**: por espécie, porte, idade, localização e situação, facilitando encontrar o pet ideal.
- **Acompanhamento de status**: usuário pode ver se seu interesse está em análise, aprovado ou pet já adotado por outra pessoa.

## Como rodar o projeto:
O Adopt Place é um app Flutter que usa o Firebase (Cloud Firestore) como banco de dados e foi testado no navegador (Chrome).

Para executá-lo, é preciso ter o Flutter SDK e o Google Chrome instalados. 

Clone o repositório, entre na pasta do projeto e baixe as dependências com flutter pub get. 

A conexão com o Firebase é feita pelo arquivo lib/firebase_options.dart, que já acompanha o repositório e aponta para o projeto adoptplace. 

Se ele não estiver presente, gere-o com o FlutterFire CLI (flutterfire configure --project=adoptplace, selecionando a plataforma web). 

O Firestore precisa ter as coleções caes (campos nome, idade, temperamento, imagem e descricao) e produtos (campos nome, preco, imagem e descricao), e as regras do banco devem permitir a leitura dessas coleções. 

Com tudo pronto, execute flutter run -d chrome e o app abrirá na tela inicial, de onde é possível acessar o feed de pets e de produtos e abrir a página de detalhes de cada item.

```
git clone <url-do-repositorio>
cd adoptPlace
cd AdoptPlace
flutter pub get
flutter run -d chrome
```
>Observação: o app não foi configurado para Windows desktop, e o build para essa plataforma exige o Firebase C++ SDK e o Visual Studio. Use o Chrome para rodar.
>É preferivel o uso do APK que se encontra em releases
---

## Decisões técnicas

| Área | Decisão | Justificativa |
|---|---|---|
| Banco de dados | Firebase (Cloud Firestore) | [por que o grupo escolheu: ex.: NoSQL flexível para cards de pets, integração nativa com Flutter, plano gratuito] |
| Armazenamento de imagens | Firebase Storage | Fotos dos pets enviadas pelas ONGs, mantidas no mesmo ecossistema do Firestore |
| Autenticação | Não implementada no CP5 | Foco no fluxo de telas; dados de usuário/ONG mockados. Planejada para o CP6 |
| Gerenciamento de estado | setState (por enquanto) | Suficiente para o protótipo; avaliar Provider no CP6 se o estado compartilhado crescer |
| Navegação | Navigator padrão (push/pop) | Simples e suficiente para o fluxo principal |
| Ambiente de teste | Chrome (Flutter web) | Execução rápida, sem depender de emulador |

- Firebase: [ex.: lista de pets e produtos no Firestore, fotos no Storage]

---

## Identidade visual:

### Logo:

<img width="500" height="330" alt="image" src="https://github.com/user-attachments/assets/4c8e0fed-2354-4a15-bcc1-69c82759930f" />


## Paleta de cores:

<img width="500" height="330" alt="image" src="https://github.com/user-attachments/assets/a2ba04b6-2cfc-4896-bc87-9f60d0b76c46" />


## Tipografia:

<img width="500" height="290" alt="image" src="https://github.com/user-attachments/assets/c43045b0-9211-4675-a4e4-94ab363da753" />
