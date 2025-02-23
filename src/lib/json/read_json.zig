const std = @import("std");

const Allocator = std.mem.Allocator;

//TODO: potentially increase file size
/// Read a JSON file from the filesystem into memory (up to 16MB) and return the parsed JSON value.
pub fn read_json(allocator: Allocator, path: []const u8) !std.json.Value {
    const data = try std.fs.cwd().readFileAlloc(allocator, path, 16_000_000);
    defer allocator.free(data);
    const parsed = try std.json.parseFromSlice(std.json.Value, allocator, data, .{ .allocate = .alloc_always });
    return parsed.value;
}

pub fn file_exists(path: []const u8) !bool {
    try std.posix.access(path, std.posix.R_OK);

    std.debug.print("found file: {s}\n", .{path});
    return true;
}

test "file_exists" {
    const fileExists = try file_exists("resources/schemas.json");
    if (!fileExists) {
        std.debug.print("file not found\n", .{});
        return;
    }
}

test "read_json" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const fileExists = try file_exists("resources/schemas.json");
    if (!fileExists) {
        std.debug.print("file not found\n", .{});
        return;
    }

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    const parsed = try read_json(allocator, "resources/schemas.json");

    try std.json.stringify(parsed, .{}, stdout);
    std.io.getStdOut().flush();
}
