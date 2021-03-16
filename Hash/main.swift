// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

class Player: PlayerProtocol, GridCellContentsProtocol {

}

print("Hello, World!")

let grid = Grid(
    size: GridSize(width: 7, height: 6),
    cellLayoutType: .q1YUp, cellFactory: nil
)

let scorer = Scorer(<#T##gridPosition: GridPoint##GridPoint#>, <#T##grid: Grid##Grid#>, <#T##player: Player##Player#>)

let lhsPlayer = Player()
let rhsPlayer = Player()

let x = Int.random(in: 0..<grid.width)
let cell = grid.cellAt(GridPoint(x: x, y: 0))
