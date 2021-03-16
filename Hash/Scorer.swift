// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

class Scorer {
    private var leftCounter: LeftCounter!
    private var rightCounter: RightCounter!
    private var upCounter: UpCounter!
    private var leftUpCounter: LeftUpCounter!
    private var rightUpCounter: RightUpCounter!
    private var downCounter: DownCounter!
    private var leftDownCounter: LeftDownCounter!
    private var rightDownCounter: RightDownCounter!

    fileprivate var grid: Grid

    public var isWinner = false
    public var longestStrand = 0

    private var counters: [ScoreCounter] {[
        leftCounter, rightCounter, upCounter, downCounter,
        leftUpCounter, leftDownCounter, rightUpCounter, rightDownCounter
    ]}

    init(_ gridPosition: GridPoint, _ grid: Grid, _ player: Player) {
        self.grid = grid

        leftCounter = .init(player, grid, gridPosition)
        rightCounter = .init(player, grid, gridPosition)
        upCounter = .init(player, grid, gridPosition)
        downCounter = .init(player, grid, gridPosition)

        leftUpCounter = .init(player, grid, gridPosition)
        rightUpCounter = .init(player, grid, gridPosition)

        leftDownCounter = .init(player, grid, gridPosition)
        rightDownCounter = .init(player, grid, gridPosition)

        checkForWin()
    }

    func checkForWin() {
        while !counters.allSatisfy({ $0.accumulate() == false }) {
            longestStrand += 1

            if counters.first( where: { $0.score >= 4 - 1 }) != nil {
                isWinner = true
            }
        }
    }
}

extension Scorer {
    class LeftCounter: ScoreCounter {
        override func next() -> Bool {
            guard gridPosition.x > 0 else { return false }
            gridPosition -= GridPoint(x: 1, y: 0)
            return true
        }
    }

    class RightCounter: ScoreCounter {
        override func next() -> Bool {
            guard gridPosition.x < (grid.width - 1) else { return false }
            gridPosition += GridPoint(x: 1, y: 0)
            return true
        }
    }

    class DownCounter: ScoreCounter {
        override func next() -> Bool {
            guard gridPosition.y > 0 else { return false }
            gridPosition += GridPoint(x: 0, y: -1)
            return true
        }
    }

    class LeftUpCounter: ScoreCounter {
        override func next() -> Bool {
            guard gridPosition.x > 0 && gridPosition.y < (grid.height - 1) else {
                return false
            }

            gridPosition += GridPoint(x: -1, y: 1)
            return true
        }
    }

    class LeftDownCounter: ScoreCounter {
        override func next() -> Bool {
            guard gridPosition.x > 0 && gridPosition.y > 0 else { return false }
            gridPosition += GridPoint(x: -1, y: -1)
            return true
        }
    }

    class RightUpCounter: ScoreCounter {
        override func next() -> Bool {
            guard gridPosition.x < (grid.width - 1) &&
                    gridPosition.y < (grid.height - 1) else { return false }

            gridPosition += GridPoint(x: 1, y: 1)
            return true
        }
    }

    class RightDownCounter: ScoreCounter {
        override func next() -> Bool {
            guard gridPosition.x < (grid.width - 1) && gridPosition.y > 0 else {
                return false
            }

            gridPosition += GridPoint(x: 1, y: -1)
            return true
        }
    }
}
