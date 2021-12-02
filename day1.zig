const std = @import("std");

const data = @embedFile("./inputs/small1");

pub fn main() !void {
    var alloc = std.heap.page_allocator;

    var lines = std.mem.tokenize(u8, data, "\n");
    var numbers = std.ArrayList(i64).init(alloc);

    while (lines.next()) |line| {
        var x: i64 = try std.fmt.parseInt(i64, line, 10);
        try numbers.append(x);
    }

    var sliding = std.ArrayList(i64).init(alloc);

    for (numbers.items) |x, index| {
        try sliding.append(x);
        if (index > 1) {
            sliding.items[index - 1] += x;
        }
        if (index > 2) {
            sliding.items[index - 2] += x;
        }
    }

    std.debug.print("Task 1: {}\nTask 2: {}\n", .{ countIncreasing(numbers.items), countIncreasing(sliding.items) });
}

fn countIncreasing(array: []i64) u16 {
    var i: u16 = 0;
    var total: u16 = 0;

    while (i < array.len - 1) : (i += 1) {
        total += @boolToInt(array[i] < array[i + 1]);
    }

    return total;
}
