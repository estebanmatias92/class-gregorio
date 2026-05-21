# Fases de batalla y efectos

## Código Original

Centralización de control de la fase de batalla, para que la IA controle fácilmente los estadios del juego.

- Centralizado
- Responsabilidad del efecto en el manejador
- 
- Manejador responsable por 
	- Timing
	- orden de las cartas
	- despachar las cartas 
	- Despachar efectos

## ¿Posible refactorización?

- Desentralizado
- Responsabilidad de efecto en la propia carta. 
- Manejador responsable por 
	- timing, 
	- orden de las cartas y 
	- despachar las cartas
	- Despachar


## Fase de combate

### Manejador

```csharp
AttackFase() {
    PreEffectFase() {
        card1.preEffect();
    }

    CardBattle() {
        BatallaSucedida tipo_batalla = BatallaSucedida.DefenseAttack;
    }

    PostEffectFase() {
        debug.log(tipo_batalla); // "DefenseAttack"
        switch (tipo_batalla) {
            case BatallaSucedida.DefenseAttack:
                card1.postEffectChangeHealth(Character);
                Character.health -= 10;
                break;
        }
    }
}
```


enum BatallaSucedida
{
DefeseAttack,
AttackAttack,
DistanceAttack
}





PreEffectFase()
	effect()
		......


PostEffectFase()
	.....
	Effect()



private effect()