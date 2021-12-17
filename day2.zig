const std = @import("std");
const data = @embedFile("./inputs/large2");
const Str = []const u8;

fn solveProblem() !i64 {
    @setEvalBranchQuota(100_000);
    var lines = std.mem.tokenize(u8, data, "\n");

    var x : i64 = 0;
    var y : i64 = 0;
    var aim : i64 = 0;

    while(lines.next()) |line| {
        var tokens = std.mem.split(u8, line, " ");

        var direction : Str = tokens.next() orelse "";
        var dist : i64 = try std.fmt.parseInt(i64, tokens.next() orelse "0", 10);
        if(std.mem.eql(u8, direction, "forward")){
            x += dist;
            y += aim * dist;
        } else if (std.mem.eql(u8, direction, "down")){
            aim += dist;
        } else if (std.mem.eql(u8, direction, "up")){
            aim -= dist;
        }
    }

    var answer : i64 = try std.math.absInt(x * y);
    return answer;
}

pub fn main() !void {
    const answer = comptime solveProblem();
    
    std.debug.print("{}\n",.{answer});
}
