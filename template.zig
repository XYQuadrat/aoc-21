const std = @import("std");
const data = @embedFile("./inputs/large2");
const Str = []const u8;

pub fn main() !void {
    var lines = std.mem.tokenize(u8, data, "\n");

    while(lines.next()) |line| {
        
    }
}
