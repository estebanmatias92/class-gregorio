# Lista de Modelos

## Lista




### GameManager

 - **Definicion**: inicializa y controla el flujo del juego
- **Miembros**
	- - Witch1: WitchScript
	- - Witch2: WitchScript
	- - ButtonContainer: Node 
	- - BattleManager: Node 
	- - DamageManager: Node 
	- - GetNode(): void
	- - SetBattleManagerWitches(): void
	- - SetButtonContainer(): void
	- - SetPlayableCards(): void
	- - CreateEnemyWitch(): void

### BattleManager

- **Definicion**: Gestiona el flujo de batalla y el comportamiento de las cartas
- **Miembros**
	- - witch1: WitchScript
	- - witch2: WitchScript
	- - cards_script: CardScript
	- - witch1SelectedCard: CardScript
	- - witch2SelectedCard: CardScript
	- - witchWithAdvantage: WitchScript
	- - StartBattle(): void
	- - CardBattle(): void
	- - BattleTypeSelector(): void
	- - CaseAbilityAbility(firstCard, secondCard, witchWithFirstCard, witchWithSecondCard): void
	- - CaseAbilityDefense(firstCard, secondCard, witchWithFirstCard, witchWithSecondCard): void
	- - CaseAbilityAttack(firstCard, secondCard, witchWithFirstCard, witchWithSecondCard): void
	- - CaseDefenseAttack(firstCard, secondCard, witchWithFirstCard, witchWithSecondCard): void
	- - CaseRangeClose(firstCard, secondCard, witchWithFirstCard, witchWithSecondCard): void
	- - CaseRangeRange(firstCard, secondCard, witchWithFirstCard, witchWithSecondCard): void
	- - CaseCloseClose(firstCard, secondCard, witchWithFirstCard, witchWithSecondCard): void
	- - StartCardAbility(card, target): void
	- - StartCardCombat(card): void
	- - StartCardHit(card, target): void
	- battleStart()
	- cardSelector(int)
### DamageManager

- **Definicion**: Resuelve el daño y los efectos durante una batalla.
- **Miembros**
	- dealDamage(WitchScript, int)
	- ...
### ButtonContainer

- **Definicion**: Gestiona el ciclo de vida y el estado de los botones.
- **Miembros**
	- setButtons()
	- setButtonText(array:CardScript)

### ButtonScript

- **Definicion**: Gestionar el comportamiento de los botones.
- **Miembros**
	- int number:get
	- setText(string)

### WitchScript

- **Definicion**: Gestiona el mazo y el personaje.
- **Miembros**
	- - WitchName: String
	- - MaxHP: int = 20
	- - CurrentHP: int = 20
	- array: CardScript Deck:get
	- array: CardScript Hand:get
	- array: CardScript Discard:get
	- drawCards()
	- ReceiveDamage(int)
	- CardScript ReturnRandomCard() #test

### CardScript

- **Definicion**: Gestionar el comportamiento de los botones.
- **Miembros**
	- CardType { ATAQUE, DEFENSA, RANGO, ABILIDAD }: enum
	- - CardName: String = "BasicCard"
	- - CardPower: int = 0
	- - CardExtraPower: int = 0
	- - CardSpeed: int = 0
	- - CardIsNegated: bool = 0
	- - CardIsMagic: bool = 0
	- - DamageManager: Node = null
	- - CardOwner: WitchScript
	- - CardEnemy: WitchScript
	- bool CardIsNegated:get
	- string CardName:get
	- int CardSpeed:get
	- CardAttack(CardScript)
	- CardEffectOnActivation(CardScript)
	- CardEffectOnHit(CardScript)
	- SetCardExtraPower(int)
	- ResetCardExtraPower()
	- int ReturnCardPower()