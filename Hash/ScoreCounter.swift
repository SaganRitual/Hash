// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

class ScoreCounter {
    let direction: GridPoint
    var gridPosition: GridPoint
    let grid: Grid
    var longestChain = 0
    let player: Player
    var score = 0

    init(
        _ grid: Grid,
        _ startPosition: GridPoint,
        _ player: Player,
        _ direction: GridPoint
    ) {
        self.direction = direction
        self.grid = grid
        self.gridPosition = startPosition
        self.player = player
    }

    func next() -> Bool {
        gridPosition += direction
        return grid.isOnGrid(gridPosition)
    }

    func accumulate() -> Bool {
        guard next() else { return false }

        guard cellAt(gridPosition).gridCellContents === player
            else { return false }

        score += 1
        return true
    }

    func cellAt(_ gridPosition: GridPoint) -> GridCellProtocol { grid.cellAt(gridPosition) }
}
