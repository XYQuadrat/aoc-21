const std = @import("std");
const data = @embedFile("./inputs/large6");
const Str = []const u8;

pub fn main() !void {
    var numbers = std.mem.tokenize(u8, data, ",");

    var count : [9]u64 = .{0} ** 9;

    while(numbers.next()) |x| {
        var value : usize = try std.fmt.parseInt(usize, x, 10);
        count[value] += 1;
    }

    var i : u64 = 0;

    while(i < 256) : (i += 1) {
        var newCount : [9]u64 = .{0} ** 9;

        newCount[0] = count[1];
        newCount[1] = count[2];
        newCount[2] = count[3];
        newCount[3] = count[4];
        newCount[4] = count[5];
        newCount[5] = count[6];
        newCount[6] = count[7] + count[0];
        newCount[7] = count[8];
        newCount[8] = count[0];

        count = newCount;
    }

    var sum : u64 = 0;
    for(count) |value| {
        sum += value;
    }

    std.debug.print("{}\n", .{sum});
}
