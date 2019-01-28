
# Projeto B: Role Playing Game

Vocês deverão fazer um jogo de RPG em turnos onde o jogador pode
controlar os personagens de sua equipe para combater monstros e outras
criaturas fantásticas.

O código base providenciado conta com um mínimo de funcionalidades de interação
para que vocês possam se concentrar mais nas funcionalidades de simulação.

Para este projeto, vocês deverão implementar uma série de mecânicas no jogo.
Sua nota será baseada na quantidade de mecânicas implementadas.

## Mecânicas para implementar

Cada mecânicas implementada vale meio (0,5) ponto, e você pode fazer quantas
conseguir (a soma total passa de dez). MAS várias mecânicas precisam que outras
mecânicas estejam funcionando antes.

### Personagens

1. Criar tipo "Character" que possui vida máxima e vida atual e usar para
representar os heróis e os monstros.

2. Todo personagem começa com sua vida atual igual a sua máxima

3. A vida máxima de cada personagem é determinada no banco de dados

4. A barra de vida deve ser atualizada de acordo com a vida atual do respectivo
personagem

### Ataque

**Requer [Personagens](#personagens)**

1. Fazer a ação de ataque reduzir a vida atual ("causar dano") do personagem
atacado

2. A redução deve ser por um valor fixo

### Morte

**Requer [Ataque](#ataque)**

1. Fazer personagens com zero ou menos de vida atual serem excluídos do combate

2. Essa verficação deve ocorrer entre turnos

### Poder

**Requer [Ataque](#ataque)**

1. Definir um atributo de poder (*power*) nos personagens

2. O poder de cada personagen é determinado no banco de dados

3. O poder influencia a quantidade de dano que um personagem causa com seu
   ataque

### Turno dos monstros

1. Fazer a rodada de turnos incluir os monstros

2. Na vez de um monstro, empilhar um estado que vai decidir a ação dele

3. Monstros a princípio devem atacar heróis aleatoriamente

### Velocidade

**Requer [Personagem](#personagem)**

1. Todo personagem tem uma atributo velocidade (*speed*)

2. A velocidade de cada personagem é definida no banco de dados

### Turnos por velocidade

**Requer [Turno dos monstros](#turno-dos-monstros), [Velocidade](#velocidade)**

1. Todo personagem tem um contador de descanso (*cooldown*)

2. Para fazer uma ação, um personagem precisa ter 100 de descanso

3. No turno de um personagem, se ele não tem 100 de descanso, então ele acumula uma quantidade de descanso igual à sua velocidade e passa a vez

4. Ao executar uma ação, o personagem zera seu contador de descanso

5. [Referência](http://journal.stuffwithstuff.com/2014/07/15/a-turn-based-game-loop/)

### Derrota

**Requer [Morte](#morte)**

1. Se todos os heróis morrerem, o jogador perde

2. Ao perder, deve aparecer uma tela de derrota

3. Ao apertar qualquer botão na tela de derrota, o jogo deve recomeçar

### Vitória

**Requer [Morte](#morte)**

1. Se todos os monstros morrerem, o jogador vence o combate

2. Ao vencer, um novo time de monstros deve aparecer para desafiá-los

3. Todos os possíveis encontros (pelo menos 3) devem ser definidos no banco de
dados

4. A sequência de encontros que o jogador enfrenta também deve ser determinada
no banco de dados (em uma pasta "adventures").

### Inventório

1. Quando um item é usado, ele é consumido

2. A equipe de heróis possui um inventário (*inventory*) com os itens que eles podem usar

3. O inventório possui 6 espaços para itens

### Tesouro

**Requer [Inventório](#inventório)**

1. Quando monstros são derrotados, itens aleatórios são dados aos heróis

2. Os possíveis itens que monstros deixam para trás deve ser especificado no banco de dados

3. Monstros só deixam itens se houver espaço no inventório dos heróis

### Itens de recuperação

**Requer [Personagens](#personagens), [Inventório](#inventório)**

1. Itens podem recuperar uma quantidade fixa de algum recurso que o personagem tenha (como sua vida atual)

2. A quantidade de recurso que eles recuperam deve ser mantida no banco de dados

3. Nem todo item possui efeito de recuperação

### Habilidades

1. Usando o estado `choose-option`, adicione uma opção no menu de ações para habilidades (*skill*)

2. A princípio, as habilidades apenas emitem uma notificação (como ataques e itens no começo do projeto)

3. Cada personagem tem uma lista de habilidade disponíveis determinada no banco de dados

### Energia

**Requer [Personagens](#personagens)**

1. O tipo "Character" possui também energia máxima e energia atual

2. Todo personagem começa com sua energia atual igual a sua máxima

3. A energia máxima de cada personagem é determinada no banco de dados

### Barra de energia

**Requer [Energia](#energia)**

1. Mostrar uma barra de energia assim como a barra de vida

2. A barra de energia deve ser atualizada de acordo com a energia atual do respectivo personagem

### Custo de habilidades

**Requer [Energia](#energia), [Habilidades](#habilidades)**

1. Habilidades consomem uma quantidade de energia para serem usadas

2. Não deve ser possível usar uma habilidade sem ter energia para tal

3. O custo de uma habilidade dever ser determinado no banco de dados

### Habilidades ofensivas

**Requer [Habilidades](#habilidades), [Poder](#poder)**

1. Habilidades ofensivas são habilidades que podem realizar um ataque proporcional ao poder do personagem que as possui

2. A proporção é dado por um multiplicador atribuído à habilidade ofensiva

### Itens de bônus

**Requer [Inventório](#inventório), [Poder](#poder), [Velocidade](#velocidade)**

1. Itens de bônus aumentam temporariamente o poder, a velocidade, ou outro atributo qualquer de um personagem que vier a existir

2. O item tem um valor de intensidade do bônus, e outro de duração

3. Os personagens só podem ter um bônus por vez, e precisam gerir sua duração

4. Nem todo item possui efeito de bônus

### Habilidades de monstros

**Requer [Turno dos monstros](#turno-dos-monstros), [Habilidades](#habilidades)**

1. Se um monstro possui habilidades, ele tem uma chance de usar suas habilidades no seu turno

2. Se a habilidade tiver alvos, eles são escolhidos aleatoriamente

### Ataque em grupo

**Requer [Habilidades ofensivas](#habilidades-ofensivas)**

1. Algumas habilidades ofensivas acertam todos seus alvos válidos

2. Essa propriedade deve ser determinada no banco de dados

## Pontos extras

Além das mecânicas, vocês podem ganhar até 1 ponto implementanto novos personagens, itens e habilidades para o jogo. Cada nova conteúdo vale **no máximo** 0.1 pontos. Para poder valer qualquer coisa, nós precisamos saber que vocês fizeram esse conteúdo!!!! Então coloque em um relatório entregue junto com o projeto uma lista de todos os conteúdos novos que fizeram, caso contrário eles não valerão nada!!!

