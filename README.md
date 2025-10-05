Bonjour,
Ce dépôt est une compilation de petits codes en ASM x86, tels que le recodage de fonctions élémentaires (`strlen`, `add`, etc.).
Il contient également un petit projet : un mini-programme qui exécute les fonctions suivantes selon votre choix :

* `Reverse`
* `Compare`
* `Len`
* `Add`
* `Exit`

Le but de ce projet était de se familiariser avec l’ASM x86 et ses notions telles que la gestion des sections, de la stack et des registres.
Il permet aussi de manipuler des concepts plus généraux de programmation, comme le parsing et la gestion des entrées/sorties.

Ce dépôt sert de base à mon projet plus ambitieux, actuellement en cours de design : un mini-shell en ASM x86-64.

Pour l’exécuter, lancez la commande suivante dans votre terminal :

```bash
make
```

En cas de problème… comme disent les bons développeurs : ça fonctionne sur ma machine, donc le problème est chez vous 😎.

PS : Tout le code a été écrit sans IA, à l’exception du Makefile.
