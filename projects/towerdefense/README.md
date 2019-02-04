
# Projeto A: Tower Defense

Vocês deverão fazer um jogo de estratégia em tempo real onde o jogador pode
comprar e posicionar torres em um campo de batalha para se defender de
hordas de invasores.

O código base providenciado conta com um mínimo de funcionalidades de interação
para que vocês possam se concentrar mais nas funcionalidades de simulação.

Para este projeto, vocês deverão implementar uma série de mecânicas no jogo.
Sua nota será baseada na quantidade de mecânicas implementadas.

## Mecânicas para implementar

Cada mecânicas implementada vale meio (0,5) ponto, e você pode fazer quantas
conseguir (a soma total passa de dez). MAS várias mecânicas precisam que outras
mecânicas estejam funcionando antes.

[ X ] Inimigos

[x] 1. Criar um tipo "Enemy" que representa os inimigos tentando invadir o jogador

[x] 2. Inimigos aparecem na margem direita da tela

[x] 3. Inimigos se movem pra esquerda em linha reta


[ X ] Derrota

**Requer [Inimigos](#inimigos)**

[x] 1. Se algum inimigo chegar na extremidade esquerda, você perde

[x] 2. Mostrar uma tela de derrota


[ X ] Vida das torres

[x] 1. Torres possuem vida atual e máxima

[x] 2. Toda torre começa com sua vida atual igual a sua máxima

[x] 3. A vida máxima de cada torre deve ser especificada no banco de dados


[ X ] Destruição de torres

**Requer [Inimigos](#inimigos) e [Vida das torres](#vida-das-torres)**

[x] 1. Quando um inimigo encosta em uma torre, ele reduz uma quantia fixa da vida
atual da torre

[x] 2. Ao causar dano, inimigos recuam alguns passos

[x] 3. Torres são destruídas quando ficam com zero de vida atual


[x] Disparos

[x] 1. Torres podem disparar projéteis

[x] 2. Cada torre tem uma taxa de disparo (*firerate*) com a qual dispara projéteis

[x] 3. Projéteis são só pequenos objetos que se movem para direita à velocidade
constante (e são destruídos se saem da tela)

[x] 4. A taxa de disparo de cada torre deve ser determinada no banco de dados


[ ] Destruição de inimigos

**Requer [Inimigos](#inimigos), [Disparos](#disparos)**

[ ] 1. Inimigos atingidos por projéteis são destruídos, a princípio

Obs.: Não conseguimos finalizar a colisão dos disparos com os inimigos, por isso fizemos a aplicação de dano e morte dos inimigos quando eles encostam nas torres

[x] Vida dos inimigos

**Requer [Destruição de inimigos](#destruição-de-inimigos)**

[x] 1. Inimigos possuem vida atual e máxima

[x] 2. Todo inimigo começa com sua vida atual igual a sua máxima

[x] 3. A vida máxima de cada inimigo deve ser especificada no banco de dados

[x] 4. Se um inimigo ficar com zero ou menos de vida atual, ele é excluído do jogo

Obs.: Não conseguimos finalizar a colisão dos disparos com os inimigos, por isso fizemos a aplicação de dano e morte dos inimigos quando eles encostam nas torres

[ ] Entidades

**Requer [Vida das torres](#vida-das-torres), [Vida dos inimigos](#vida-dos-inimigos)**

[ ] 1. Refatorar o código repetido de vida de torres e inimigos para um só lugar

[ ] 2. Fazer que ambos sejam subtipos de entidades (*entities*)


[x] Poder dos inimigos

**Requer [Destruição de torres](#destruição-de-torres)**

[x] 1. Inimigos possuem um valor de poder (*power*)

[x] 2. Esse valor é determinado pelo banco de dados

[x] 3. Quando inimigos encostam em uma torre, eles reduzem uma quantidade de vida igual ao seu poder (ao invés de uma quantidade fixa universal)


[ ] Poder das torres

**Requer [Vida dos inimigos](#vida-dos-inimigos)**

[x] 1. Torres possuem um valor de poder (*power*)

[x] 2. Esse valor é determinado pelo banco de dados

[ ] 3. Quando projéteis disparados por uma torre acertam um inimigo, eles reduzem uma quantidade de vida igual ao seu poder (ao invés de destruí-los invariavelmente)


[ X ] Dinheiro

[ X ] 1. Você gasta dinheiro quando constrói uma torre

[ X ] 2. Você não pode construir uma torre se não tiver dinheiro para tal

[ X ] 3. Você ganha dinheiro quando derrota inimigos


[ X ] Custo de torres

**Requer [Dinheiro](#dinheiro)**

[ X ] 1. Toda torre possui um custo

[ X ] 2. O custo de uma torre é o valor gasto para construí-la


[ X ] Valor dos inimigos

**Requer [Dinheiro](#dinheiro)**

[ X ] 1. Todo inimigo possui um valor

[ X ] 2. A quantidade de dinheito ganha por derrotar um inimigo é determinada pelo seu valor


[ X ] Sucatear

**Requer [Dinheiro](#dinheiro)**

[ X ] 1. Você pode clicar com botão direito numa torre para destruir ela e ganhar
metade do valor de volta


[ X ] Progressão

**Requer [Inimigos](#inimigos)**

[ X ] 1. A quantidade de inimigos criados aumenta ao longo do tempo


[ X ] Velocidade de inimigos

**Requer [Inimigos](#inimigos)**

[ X ] 1. Todo inimigo possui uma velocidade (*speed*)

[ X ] 2. Essa velocidade determina a velocidade de movimento dos inimigos

[ X ] 3. A velocidade de cada inimigo é determinada no banco de dados


[ ] Mineradoras

**Requer [Dinheiro](#dinheiro)**

[ ] 1. Mineradoras são torres que produzem dinheiro de tempos em tempos

[ ] 2. Toda mineradora tem uma taxa de produção com a qual ela produz dinheiro

[ ] 3. A taxa de produção de cada mineradora é determinada no banco de dados


[ ] Movimento lateral

**Requer [Inimigos](#inimigos)**

[ ] 1. Inimigos podem se mover lateralmente, avançando diagonalmente pelo mapa

[ ] 2. Inimigos determinam seus movimento através de uma série de pares (direção, duração), onde direção pode ser "frente", "cima" ou "baixo", e duração é um valor em segundos

[ ] 3. A sequência de movimentos de cada inimigo deve ser determinada no banco de dados


[ ] Torres temporárias

[ ] 1. Torres podem ter uma duração, que indica quantos segundos elas ficam em jogo antes de serem destruídas por desgaste

[ ] 2. Para isso, elas também precisam de um contador de tempo, que ajuda a detectar quando a duração da torre passou

[ ] 3. A duração de cada torre deve ser determinada no banco de dados

[ ] 4. Uma duração de zero indica que a torre dura pra sempre ou até ser destruída


[ ] Disparos paralizantes

**Requer [Poder das torres](#poder-das-torres)**

[ ] 1. Torres podem disparar projéteis que, ao invés de causar dano, paralizam o movimento do inimigo atingido por uma certa quantidade de tempo

[ ] 2. Essa propriedade dos disparos de uma torre deve ser determinada no banco de dados

[ ] 3. Inimigos precisam ter um contador de paralisia que indica por quantos segundos eles estão paralizados, e esse contador diminui com o tempo


[ ] Pontos extras

Além das mecânicas, vocês podem ganhar até 1 ponto implementanto novas torres e inimigos para o jogo. Cada nova torre e inimigo vale **no máximo** 0.1 pontos. Para poder valer qualquer coisa, nós precisamos saber que vocês fizeram esse conteúdo!!!! Então coloque em um relatório entregue junto com o projeto uma lista de todos os conteúdos novos que fizeram, caso contrário eles não valerão nada!!!

Algumas sugestões:
+ **Barricadas**. Torre com vida máxima alta, taxa de disparo zero. São alternativas baratas para segurar as hordas de invasores por um pouco mais de tempo.
+ **Tanque**. Inimigo com vida máxima alta e velocidade bastante reduzida. Um alvo fácil mas persistente.
+ **Torre de emergência**. Torre com vida máxima baixa, alta taxa de disparo e poder, mas durabilidade curta e bastante cara. Situações drásticas exigem medidas drásticas.


