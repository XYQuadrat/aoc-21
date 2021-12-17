const std = @import("std");
const data = @embedFile("./inputs/large4");
const Str = []const u8;

const Board = struct {
    numbers: [25]u8,
    checked: [25]bool,
    won: bool = false,
};

pub fn main() !void {
    var alloc = std.heap.page_allocator;
    var lines = std.mem.tokenize(u8, data, "\n");

    var draws = blk: {
        var draws = std.ArrayList(u8).init(alloc);
        var line = std.mem.tokenize(u8, lines.next().?, ",");
        while(line.next()) |draw| {
            try draws.append(try std.fmt.parseInt(u8, draw, 10));
        }

        break :blk draws.toOwnedSlice();
    };

    var boards = blk: {
        var boards = std.ArrayList(Board).init(alloc);
        while (true) {
            var board : Board = .{ .numbers = undefined, .checked = .{false} ** 25 };
            var i: u8 = 0; 
            while (i < 25) : (i += 1) {
                const line = lines.next() orelse {
                    break :blk boards.toOwnedSlice();
                };

                board.numbers[i] = try std.fmt.parseInt(u8, line, 10);
            }

            try boards.append(board);
        }
    };

    var boardsWon : u32 = 0;

    for(draws) |draw| {
        for(boards) |*board| {
            if(!board.*.won) {
                for(board.*.numbers) |value, i| {
                    if(value == draw) {
                        board.*.checked[i] = true;

                        if(hasWon(board.*)) {
                            boardsWon += 1;
                            board.*.won = true;
                        }

                        if(boardsWon == boards.len) {
                            std.debug.print("{}\n", .{score(board.*) * draw});
                            return;
                        }
                    }
                }
            }
        }
    }
}

fn hasWon(board: Board) bool {
    var i : u8 = 0;

    while (i < 25) : (i += 5) {
        if(board.checked[i] 
            and board.checked[i + 1] 
            and board.checked[i + 2]
            and board.checked[i + 3]
            and board.checked[i + 4]){
                return true;
        }
    }

    i = 0;

    while (i < 5) : (i += 1) {
        if(board.checked[i]
            and board.checked[i+5]
            and board.checked[i+10]
            and board.checked[i+15]
            and board.checked[i+20]) {
                return true;
        }
    }

    return false;
}

fn score(board : Board) u64 {
    var total : u64 = 0;
    for(board.numbers) |number, i| {
        if(!board.checked[i]) {
            total += number;
        }
    } 

    return total;
}