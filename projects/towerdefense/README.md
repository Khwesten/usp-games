
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

1. Criar um tipo "Enemy" que representa os inimigos tentando invadir o jogador

2. Inimigos aparecem na margem direita da tela

3. Inimigos se movem pra esquerda em linha reta


[ X ] Derrota

**Requer [Inimigos](#inimigos)**

1. Se algum inimigo chegar na extremidade esquerda, você perde

2. Mostrar uma tela de derrota


[ X ] Vida das torres

1. Torres possuem vida atual e máxima

2. Toda torre começa com sua vida atual igual a sua máxima

3. A vida máxima de cada torre deve ser especificada no banco de dados


[ ] Destruição de torres

**Requer [Inimigos](#inimigos) e [Vida das torres](#vida-das-torres)**

1. Quando um inimigo encosta em uma torre, ele reduz uma quantia fixa da vida
atual da torre

2. Ao causar dano, inimigos recuam alguns passos

3. Torres são destruídas quando ficam com zero de vida atual


[ ] Disparos

1. Torres podem disparar projéteis

2. Cada torre tem uma taxa de disparo (*firerate*) com a qual dispara projéteis

3. Projéteis são só pequenos objetos que se movem para direita à velocidade
constante (e são destruídos se saem da tela)

4. A taxa de disparo de cada torre deve ser determinada no banco de dados


[ ] Destruição de inimigos

**Requer [Inimigos](#inimigos), [Disparos](#disparos)**

1. Inimigos atingidos por projéteis são destruídos, a princípio


[ ] Vida dos inimigos

**Requer [Destruição de inimigos](#destruição-de-inimigos)**

1. Inimigos possuem vida atual e máxima

2. Todo inimigo começa com sua vida atual igual a sua máxima

3. A vida máxima de cada inimigo deve ser especificada no banco de dados

4. Se um inimigo ficar com zero ou menos de vida atual, ele é excluído do jogo


[ ] Entidades

**Requer [Vida das torres](#vida-das-torres), [Vida dos inimigos](#vida-dos-inimigos)**

1. Refatorar o código repetido de vida de torres e inimigos para um só lugar

2. Fazer que ambos sejam subtipos de entidades (*entities*)


[ ] Poder dos inimigos

**Requer [Destruição de torres](#destruição-de-torres)**

1. Inimigos possuem um valor de poder (*power*)

2. Esse valor é determinado pelo banco de dados

3. Quando inimigos encostam em uma torre, eles reduzem uma quantidade de vida igual ao seu poder (ao invés de uma quantidade fixa universal)


[ ] Poder das torres

**Requer [Vida dos inimigos](#vida-dos-inimigos)**

1. Torres possuem um valor de poder (*power*)

2. Esse valor é determinado pelo banco de dados

3. Quando projéteis disparados por uma torre acertam um inimigo, eles reduzem uma quantidade de vida igual ao seu poder (ao invés de destruí-los invariavelmente)


[ X ] Dinheiro

1. Você gasta dinheiro quando constrói uma torre

2. Você não pode construir uma torre se não tiver dinheiro para tal

2. Você ganha dinheiro quando derrota inimigos


[ ] Custo de torres

**Requer [Dinheiro](#dinheiro)**

1. Toda torre possui um custo

2. O custo de uma torre é o valor gasto para construí-la


[ ] Valor dos inimigos

**Requer [Dinheiro](#dinheiro)**

1. Todo inimigo possui um valor

2. A quantidade de dinheito ganha por derrotar um inimigo é determinada pelo seu valor


[ ] Sucatear

**Requer [Dinheiro](#dinheiro)**

1. Você pode clicar com botão direito numa torre para destruir ela e ganhar
metade do valor de volta


[ X ] Progressão

**Requer [Inimigos](#inimigos)**

1. A quantidade de inimigos criados aumenta ao longo do tempo


[ X ] Velocidade de inimigos

**Requer [Inimigos](#inimigos)**

1. Todo inimigo possui uma velocidade (*speed*)

2. Essa velocidade determina a velocidade de movimento dos inimigos

3. A velocidade de cada inimigo é determinada no banco de dados


[ ] Mineradoras

**Requer [Dinheiro](#dinheiro)**

1. Mineradoras são torres que produzem dinheiro de tempos em tempos

2. Toda mineradora tem uma taxa de produção com a qual ela produz dinheiro

3. A taxa de produção de cada mineradora é determinada no banco de dados


[ ] Movimento lateral

**Requer [Inimigos](#inimigos)**

1. Inimigos podem se mover lateralmente, avançando diagonalmente pelo mapa

2. Inimigos determinam seus movimento através de uma série de pares (direção, duração), onde direção pode ser "frente", "cima" ou "baixo", e duração é um valor em segundos

3. A sequência de movimentos de cada inimigo deve ser determinada no banco de dados


[ ] Torres temporárias

1. Torres podem ter uma duração, que indica quantos segundos elas ficam em jogo antes de serem destruídas por desgaste

2. Para isso, elas também precisam de um contador de tempo, que ajuda a detectar quando a duração da torre passou

3. A duração de cada torre deve ser determinada no banco de dados

4. Uma duração de zero indica que a torre dura pra sempre ou até ser destruída


[ ] Disparos paralizantes

**Requer [Poder das torres](#poder-das-torres)**

1. Torres podem disparar projéteis que, ao invés de causar dano, paralizam o movimento do inimigo atingido por uma certa quantidade de tempo

2. Essa propriedade dos disparos de uma torre deve ser determinada no banco de dados

3. Inimigos precisam ter um contador de paralisia que indica por quantos segundos eles estão paralizados, e esse contador diminui com o tempo


[ ] Pontos extras

Além das mecânicas, vocês podem ganhar até 1 ponto implementanto novas torres e inimigos para o jogo. Cada nova torre e inimigo vale **no máximo** 0.1 pontos. Para poder valer qualquer coisa, nós precisamos saber que vocês fizeram esse conteúdo!!!! Então coloque em um relatório entregue junto com o projeto uma lista de todos os conteúdos novos que fizeram, caso contrário eles não valerão nada!!!

Algumas sugestões:
+ **Barricadas**. Torre com vida máxima alta, taxa de disparo zero. São alternativas baratas para segurar as hordas de invasores por um pouco mais de tempo.
+ **Tanque**. Inimigo com vida máxima alta e velocidade bastante reduzida. Um alvo fácil mas persistente.
+ **Torre de emergência**. Torre com vida máxima baixa, alta taxa de disparo e poder, mas durabilidade curta e bastante cara. Situações drásticas exigem medidas drásticas.


