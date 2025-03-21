const std = @import("std");
const xml = @cImport(@cInclude("libxml/parser.h"));
const json = @import("src/lib/json")

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();



    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "initialize parser" {
    const parser = xml.xmlCreatePushParserCtxt(null, null, null, 0, null);
    try std.testing.expect(parser != null);
    xml.xmlFreeParserCtxt(parser);
}
