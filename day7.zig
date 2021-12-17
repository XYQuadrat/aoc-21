const std = @import("std");
const data = @embedFile("./inputs/large7");
const Str = []const u8;

fn calcFuel(positions : std.ArrayList(i64), x : i64) i64 {
    var fuel : i64 = 0;

    for(positions.items) |position| {
        var diff : i64 = std.math.absInt(x - position) catch unreachable;
        fuel += @divFloor(diff * diff + diff,2);
    }

    return fuel;
}

pub fn main() !void {
    var alloc = std.heap.page_allocator;
    var lines = std.mem.tokenize(u8, data, ",");
    var positions : std.ArrayList(i64) = std.ArrayList(i64).init(alloc);

    while(lines.next()) |line| {
        const position = std.fmt.parseInt(i64, line, 10) catch unreachable;
        try positions.append(position);        
    }

    var i : i64 = 0;
    var minFuel : i64 = std.math.maxInt(i64);

    while(i < 2000) : (i += 1) {
        minFuel = std.math.min(minFuel, calcFuel(positions, i));
    }

    std.debug.print("{}\n", .{minFuel});
}
