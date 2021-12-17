const std = @import("std");
const data = @embedFile("./inputs/large5");
const Str = []const u8;

pub fn main() !void {
    var lines = std.mem.tokenize(u8, data, "\n");
    var grid: [1000][1000]u16 = .{.{0} ** 1000} ** 1000;

    while (lines.next()) |line| {
        var tokens = std.mem.tokenize(u8, line, ",");
        var x1: u32 = std.fmt.parseInt(u32, tokens.next().?, 10) catch unreachable;
        var y1: u32 = std.fmt.parseInt(u32, tokens.next().?, 10) catch unreachable;
        var x2: u32 = std.fmt.parseInt(u32, tokens.next().?, 10) catch unreachable;
        var y2: u32 = std.fmt.parseInt(u32, tokens.next().?, 10) catch unreachable;

        if (x1 == x2) {
            while (y1 != y2) {
                grid[y1][x1] += 1;

                y1 = if (y1 > y2) y1 - 1 else y1 + 1;
            }
        } else if (y1 == y2) {
            while (x1 != x2) {
                grid[y1][x1] += 1;

                x1 = if (x1 > x2) x1 - 1 else x1 + 1;
            }
        } else {
            while (x1 != x2 and y1 != y2) {
                grid[y1][x1] += 1;

                x1 = if (x1 > x2) x1 - 1 else x1 + 1;
                y1 = if (y1 > y2) y1 - 1 else y1 + 1;
            }
        }

        grid[y1][x1] += 1;
    }

    var overlap: u64 = 0;

    for (grid) |rows| {
        for (rows) |x| {
            if (x >= 2) {
                overlap += 1;
            }
        }
    }

    std.debug.print("{d}\n", .{overlap});
}
