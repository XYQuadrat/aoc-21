const std = @import("std");
const utils = @import("./utils.zig");
var gpa = utils.gpa;

const data = @embedFile("./inputs/small1");

pub fn main() !void {
    var alloc = std.heap.page_allocator;

    var lines = std.mem.tokenize(u8, data, "\n");

    var numbers = std.ArrayList(u16).init(alloc);
    defer numbers.deinit();

    while(lines.next()) |line| {
        var i = try std.fmt.parseInt(u16, std.mem.trimRight(u8, line, "\n"), 0);
        try numbers.append(i);
    }

    var i : u16 = 2;
    var total : u16 = 0;

    var previous : u16 = numbers.items[0] + numbers.items[1];
    var current : u16 = numbers.items[1];
    var next : u16 = 0;

    while (i < numbers.items.len) : (i += 1) {
        next = numbers.items[i];
        current += numbers.items[i];
        previous += numbers.items[i];
        if(previous > current){
            total += 1;
        }
        previous = current;
        current = next;
    }

    std.debug.print("\n{}\n", .{total});
}