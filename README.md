# Blocks in Bits
This game was made using Godot version 4.3 (stable) and is available on [itch.io](https://tfcb93.itch.io/blocks-in-bits).

## About the game

This game is about breaking blocks using tools. Through it, the player will have to update your tools since the blocks will become stronger and harder to break. Breaking a block gives you points and 1 second in your time. Tools have multipliers, giving you more points. The game ends when the time reaches 0 seconds.
The initial idea of this game was to create a "screen smasher" where the player has to tap the screen as much as they can to destroy the biggest amount of blocks they can, but during development, the game proved uninteresting. From there, other ideas came into the scene, like specific blocks that would be destroyed by certain tools. Still, the game remained uninteresting, and the code became hard to maintain.
With that, the game was abandoned, since the idea wasn't fun. However, it was decided to finalize it, revamping and open-sourcing.
They are still not 100% balanced and might reach impossible levels, especially after the last tool upgrade. Some work has been done, such as evaluating data and getting a good balance, but it's unclear how well it works.

## A bit about the code

The code organization lacks a few parts, like reading controls spread over a few files instead of unified, events organization and usage, and better integration between desktop, web, and mobile versions, making it more uniform (still unclear how to do so).
The engine presented me with two problems, one of which should be resolved by the engine. The first one is the focus on disabled buttons. They decided to [include by design](https://github.com/godotengine/godot-proposals/issues/7320#issuecomment-1640997716) that buttons must have focus even if they are disabled. This problem could be changed via code, but implementing it on each button that needs to be disabled becomes hard to maintain.
Another problem was the change of extensions, which Godot applies to custom resources, calling it `.import.remap`. The different builds can't recognize it, so they are not loading it and breaking the game. [The only solution found was to detect the suffix and remove it](https://github.com/godotengine/godot/issues/66014#issuecomment-1832988310), as said in this [Godot issue](https://github.com/godotengine/godot/issues/66014). This problem should be more properly addressed, or at least make it easy to find a solution. In other ways, it's stupid.

## Conclusion

The development of this project was good to learn more about Godot, and opening its source may help other developers as a reference or inspiration for new ideas. For any problem, question, or contribution regarding it just open an issue.


## Misc.

You might be able to get the first version rolling back few pushes into main, before the `redesign`. Here few images of it:  
![First version title screen](./doc/images/Version%201.png)