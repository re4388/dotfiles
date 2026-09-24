# GhidrAssistMCP tool & prompt reference

Auto-generated from the live server (49 tools). The MCP server runs on `http://127.0.0.1:8080/mcp` (streamable HTTP) and `http://127.0.0.1:8080/sse` (SSE).

When called through opencode, every tool is prefixed with `ghidra_` (e.g. `get_code` -> `ghidra_get_code`).


## Tools


### `analysis_control`

Check Auto Analysis status or request cancellation of queued analysis for current/specified/all open programs. Use MCP task tools (get_task_status/cancel_task) for analyze_program task tracking.

| param | type | description |
|---|---|---|
| `action*` | string | Operation to perform |
| `scope` | string | Program scope. Default: current |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `analysis_options`

List, set, reset, save, and apply Ghidra Auto Analysis options. Plugin-provided Auto Analyzers appear here when their analyzers are registered for the program.

| param | type | description |
|---|---|---|
| `filter` | string | For action='list': optional case-insensitive substring filter for option names |
| `preset_name` | string | Preset name for save_preset/apply_preset/delete_preset |
| `offset` | integer | For action='list': number of matching options to skip. Default: 0 |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |
| `options` | object | For action='set' or 'save_preset': mapping of analysis option names to values |
| `limit` | integer | For action='list': maximum options to return. Default: 200 |
| `action*` | string | Operation to perform |
| `option_names` | array | For action='reset' or 'save_preset': list of analysis option names |


### `analyze_function`

Get detailed information about a specific function

| param | type | description |
|---|---|---|
| `function_name*` | string |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `analyze_program`

Run Ghidra Auto Analysis on the current/specified program or all open programs. Supports full re-analysis, pending-changes analysis, optional address range restriction, and per-call analysis option overrides.

| param | type | description |
|---|---|---|
| `options` | object | Optional analysis option overrides to apply before analysis |
| `mode` | string | Analysis mode. 'full' schedules all program bytes/range for re-analysis; 'changes' waits for pending analysis only. Default: full |
| `end_address` | string | Optional range end address for mode='full' on a single program |
| `start_address` | string | Optional range start address for mode='full' on a single program |
| `scope` | string | Program scope to analyze. Default: current |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `assemble_code`

Assemble instruction text at an address and optionally patch it into program memory. Example: {"address":"0x401000","code":"NOP","patch":true}

| param | type | description |
|---|---|---|
| `patch` | boolean | If true, patch assembled bytes into the program. If false, only return bytes. Default: true |
| `address*` | string | Address where the assembly should be encoded (e.g. '0x401000' or '401000') |
| `code*` | string | Assembly instruction text. May be a single instruction or newline-separated block. |
| `clear_code_units` | boolean | When patching, clear existing instructions/data across the assembled range first. Default: true |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `batch_rename`

Batch rename symbols (functions, data/labels, or local variables) with partial success reporting

| param | type | description |
|---|---|---|
| `renames*` | array |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `bookmarks`

Manage bookmarks: list, add, or delete bookmarks at addresses

| param | type | description |
|---|---|---|
| `action*` | string | Bookmark operation to perform |
| `comment` | string | Optional: comment text (add) |
| `address` | string | Address string (required for add/delete) |
| `type` | string | Optional: bookmark type string (defaults to NOTE for add; for delete, if omitted deletes all bookmark types at address) |
| `category` | string | Optional: category to filter by (list) or set (add) |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `cancel_task`

Cancel a running async task

| param | type | description |
|---|---|---|
| `task_id*` | string |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `classes`

Class operations: list (with optional pattern filtering) or get_info for detailed class information

| param | type | description |
|---|---|---|
| `offset` | integer |  |
| `case_sensitive` | boolean |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |
| `pattern` | string |  |
| `limit` | integer |  |
| `action*` | string | Class operation to perform |
| `class_name` | string |  |


### `close_program`

Close an open program in CodeBrowser. If name is omitted, closes the current program. Changed programs require save=true or ignore_changes=true.

| param | type | description |
|---|---|---|
| `name` | string | Open program name or project path to close. If omitted, closes the current program. |
| `save` | boolean | Save the program before closing if it has changes. Default: false. |
| `ignore_changes` | boolean | Close without saving even if the program has changes. Default: false. |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `comments`

Comment operations: get, set, list, or remove comments on functions or addresses

| param | type | description |
|---|---|---|
| `action*` | string | Comment operation to perform |
| `comment` | string | Comment text (required for set) |
| `address` | string | Address for get/set/remove operations |
| `comment_type` | string | Comment type: eol, pre, post, plate, repeatable (default: eol) |
| `function_name` | string | Function name for get (function comment) or list (all comments in function) |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `create_data_var`

Create a defined data variable at a specific address

| param | type | description |
|---|---|---|
| `name` | string | Optional name for the data variable |
| `data_type*` | string | Data type name |
| `address*` | string | Address for the data variable |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `create_function`

Create (define) a function at a specific address. Ghidra will auto-detect the function body via flow analysis. Optionally clear existing code/data units first and provide a name for the function.

| param | type | description |
|---|---|---|
| `clear_existing` | boolean | Clear existing instructions/data before creating the function. Default: false. |
| `name` | string | Optional name for the function (default: auto-generated FUN_xxxx) |
| `clear_length` | integer | When clear_existing=true, bytes to clear from the entry address. If omitted, clears only the code/data unit containing the entry. |
| `address*` | string | Entry point address for the function (e.g. '0xC121' or 'C121') |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `disassemble_at`

Disassemble code at a specific address, even if no function is defined. Converts undefined bytes into instructions and can optionally clear existing code/data units first.

| param | type | description |
|---|---|---|
| `clear_existing` | boolean | Clear existing instructions/data in the range before disassembly. Default: false. |
| `length` | integer | Number of bytes to disassemble or clear (default: 128) |
| `address*` | string | Start address to disassemble (e.g. '0xC121' or 'C121') |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `export_program`

Export the program to disk. Supports format 'binary' (raw bytes) or 'original_file'. Use after patching bytes to write a modified binary. SECURITY: This tool writes to the host filesystem and is disabled by default.

| param | type | description |
|---|---|---|
| `format` | string | Export format |
| `output_path*` | string | Absolute output path on the host filesystem |
| `overwrite` | boolean | Overwrite existing file. Default: false |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_basic_blocks`

Get basic blocks and control flow graph for a function

| param | type | description |
|---|---|---|
| `function*` | string |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_binary_info`

Get information about the currently loaded program

| param | type | description |
|---|---|---|
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_code`

Get code representation of a function in various formats (decompiler, disassembly, or pcode)

| param | type | description |
|---|---|---|
| `format*` | string | Output format for the requested function |
| `raw` | boolean | Optional: Only affects format 'pcode' (raw pcode ops vs grouped by basic blocks) |
| `function*` | string | Function identifier (name, qualified name like Namespace::Func, or address like 0x401000) |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_current_address`

Get the current cursor address in Ghidra

| param | type | description |
|---|---|---|
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_current_function`

Get the current function containing the cursor in Ghidra

| param | type | description |
|---|---|---|
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_data_at`

Get a hexdump of memory at a specific address in standard hex+ASCII format. Useful for examining data structures, .rodata, .data, .bss, and other non-code regions.

| param | type | description |
|---|---|---|
| `len*` | number |  |
| `address*` | string |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_data_vars`

List defined data elements in the program

| param | type | description |
|---|---|---|
| `limit` | integer |  |
| `offset` | integer |  |
| `data_type_filter` | string |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_entry_points`

Get the entry points of the program

| param | type | description |
|---|---|---|
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_exports`

List exported functions and symbols

| param | type | description |
|---|---|---|
| `offset` | integer |  |
| `limit` | integer |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_function_signature`

Get the native GhidrAssist byte signature for a function

| param | type | description |
|---|---|---|
| `function_name_or_address*` | string | Function name, qualified name, or address |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_function_stack_layout`

Get the stack frame layout for a function

| param | type | description |
|---|---|---|
| `function_name_or_address*` | string | Function name or address |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_function_statistics`

Get statistics about functions in the program

| param | type | description |
|---|---|---|
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_functions`

List functions with optional pattern filtering and pagination

| param | type | description |
|---|---|---|
| `limit` | integer |  |
| `pattern` | string |  |
| `offset` | integer |  |
| `case_sensitive` | boolean |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_imports`

List imported functions and symbols

| param | type | description |
|---|---|---|
| `offset` | integer |  |
| `limit` | integer |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_namespaces`

List namespaces in the program

| param | type | description |
|---|---|---|
| `offset` | integer |  |
| `limit` | integer |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_relocations`

List relocation entries from the program's relocation table

| param | type | description |
|---|---|---|
| `offset` | integer |  |
| `limit` | integer |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_segments`

List memory segments/blocks in the program

| param | type | description |
|---|---|---|
| `offset` | integer |  |
| `limit` | integer |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_strings`

List string data found in the program, with optional filtering

| param | type | description |
|---|---|---|
| `limit` | integer |  |
| `filter` | string |  |
| `offset` | integer |  |
| `min_length` | integer |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `get_task_status`

Get the status of an async task, or retrieve its result if completed

| param | type | description |
|---|---|---|
| `task_id*` | string |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `import_file`

Import a binary file into the current Ghidra project. Supports raw binary imports with configurable language/processor, base address, file offset, and length. SECURITY: This tool can read files from the host file system - it is disabled by default and must be explicitly enabled. Example: {"file_path": "C:/roms/bank00.bin", "language": "6502:LE:16:default", "base_address": "0x8000"}

| param | type | description |
|---|---|---|
| `suppress_analysis_prompt` | boolean | If open_after_import is true, set 'Should Ask To Analyze' to false before opening. Default: true. |
| `file_path*` | string | Absolute path to the binary file on the host file system |
| `folder` | string | Destination folder in the Ghidra project (e.g. '/' or '/banks'). Default: '/'. |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |
| `language` | string | Language ID: processor:endian:size:variant (e.g. '6502:LE:16:default', 'x86:LE:32:default', 'ARM:LE:32:v8'). If omitted, Ghidra will attempt auto-dete |
| `base_address` | string | Base address in hex (e.g. '0x8000'). Applied after import by setting the program image base. |
| `compiler` | string | Compiler spec ID (e.g. 'default', 'gcc', 'windows'). Defaults to 'default'. |
| `open_after_import` | boolean | Open the imported program in CodeBrowser after import. Default: true. |


### `list_binaries`

List all currently open programs/binaries in Ghidra. Shows program names, project paths, executable paths, and which one is currently active. Use this to discover available targets before running other tools. IMPORTANT: When multiple programs are open, use the 'program_name' parameter with the listed Project Path to specify which program to operate on. Example: {}

| param | type | description |
|---|---|---|
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `list_tasks`

List all async tasks with their status

| param | type | description |
|---|---|---|
| `status` | string | Optional: filter tasks by status |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `open_program`

Open a program from the Ghidra project in CodeBrowser, or list all programs available in the project. Use action 'list' to see all project files, or 'open' to open one by name or full path. Example: {"action": "open", "name": "/banks/bank00.bin"}

| param | type | description |
|---|---|---|
| `suppress_analysis_prompt` | boolean | For action 'open': set 'Should Ask To Analyze' to false before opening. Default: true. |
| `analyze_after_open` | boolean | For action 'open': submit an analyze_program task after opening. Default: false. |
| `analysis_mode` | string | For analyze_after_open: analysis mode |
| `folder` | string | Project folder to search in (e.g. '/' or '/banks'). Default: search all folders. |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |
| `name` | string | Program name or full project path to open (required for action 'open'). Supports partial name matching. |
| `analysis_options` | object | For analyze_after_open: optional analysis option overrides |
| `action*` | string | Operation to perform |


### `patch_bytes`

Patch raw bytes at an address. Example: {"address":"0x401000","bytes":"90 90"}

| param | type | description |
|---|---|---|
| `address*` | string | Address to patch (e.g. '0x401000' or '401000') |
| `bytes*` | ? | Bytes to write. Either a hex string (e.g. '90 90') or an integer array (e.g. [144, 144]). |
| `clear_code_units` | boolean | If true, clear existing instructions/data at the patched range before writing. Default: false |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `project_files`

List or delete files/folders in the active Ghidra project. Deletion requires confirm=true and removes Ghidra project database entries, not original imported files.

| param | type | description |
|---|---|---|
| `confirm` | boolean | Required true for action='delete' |
| `path` | string | Project path for action='delete' (e.g. '/banks/bank00.bin' or '/banks') |
| `folder` | string | Project folder to list. Default: '/' |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |
| `target_type` | string | For delete: file, folder, or auto. Default: auto |
| `action*` | string | Operation to perform |
| `recursive` | boolean | For list/delete folder: include/delete children recursively. Default: false |


### `rename_symbol`

Rename a symbol (function, data/label, or local variable)

| param | type | description |
|---|---|---|
| `target_type*` | string | What kind of symbol to rename |
| `identifier*` | string | Target identifier (function: old function name; data: address string; variable: function name) |
| `variable_name` | string | Required when target_type is 'variable': old local name to rename |
| `new_name*` | string | New symbol name (functions may be qualified like Namespace::Func) |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `scripts`

List, read, create, delete, and run Ghidra scripts. Create/delete are restricted to the user script directory; run uses Ghidra's script providers.

| param | type | description |
|---|---|---|
| `filter` | string | For action='list': case-insensitive substring filter |
| `confirm` | boolean | Required true for action='delete' |
| `args` | array | For action='run': script arguments |
| `offset` | integer | For action='list': number of matching scripts to skip. Default: 0 |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |
| `limit` | integer | For action='list': maximum scripts to return. Default: 200 |
| `name` | string | Script file name or relative path, e.g. 'MyScript.java' |
| `action*` | string | Operation to perform |
| `user_only` | boolean | For action='list': only list scripts in the user script directory. Default: false |
| `max_bytes` | integer | For action='get': maximum source bytes to return. Default: 65536 |
| `source` | string | For action='create': script source text. If omitted, provider template is used. |
| `overwrite` | boolean | For action='create': overwrite an existing user script. Default: false |


### `search_bytes`

Search for byte patterns in program memory (hex string with optional wildcards '??')

| param | type | description |
|---|---|---|
| `limit` | integer |  |
| `pattern*` | string |  |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `search_functions_by_name`

Search for functions whose name contains the search term

| param | type | description |
|---|---|---|
| `search_term*` | string | Search term to match against function names |
| `limit` | integer | Maximum results (default 100) |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `search_strings`

Search for strings matching a pattern in the program

| param | type | description |
|---|---|---|
| `pattern*` | string | Search pattern to match against string content |
| `limit` | integer | Maximum results (default 100) |
| `case_sensitive` | boolean | Case sensitive search (default false) |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |


### `struct`

Structure operations: create, modify, merge, set_field, name_gap, auto_create, rename_field, or field_xrefs

| param | type | description |
|---|---|---|
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |
| `update_packing` | boolean | For action='merge': if true, update the target structure's packing setting to match the parsed C definition. Default false. |
| `pointer_level` | integer | For action='set_field': number of pointer indirections to apply to data_type (e.g. 1 for T*, 2 for T**). Default 0. |
| `array_count` | integer | For action='set_field': if provided, wraps the (possibly pointer-adjusted) type in an array of this many elements. |
| `function_identifier` | string | For action='auto_create': function name or address identifying which function to decompile |
| `structure_name` | string | For action='modify'/'rename_field'/'field_xrefs': target structure name (searched in '/', '/auto_structs/', and by bare name) |
| `limit` | integer | For action='field_xrefs': maximum number of references to return (default 100) |
| `action*` | string | Structure operation to perform |
| `variable_name` | string | For action='auto_create': variable name in the decompiler output to infer/apply a structure to |
| `old_field_name` | string | For action='rename_field': existing field name to rename (provide either old_field_name or offset) |
| `packed` | boolean | For action='create' with name: if true, enable packing (no implicit alignment/padding). Default false. |
| `allow_empty` | boolean | For action='modify': if true, allow replacing a non-empty struct with an empty parsed definition. Default false (safety). |
| `new_name` | string | For action='modify': optional new name to rename the structure to |
| `new_field_name` | string | For action='rename_field': new field name |
| `op` | string | For action='set_field': how to apply the field at offset. |
| `grow` | boolean | For action='set_field'/'name_gap': if true, grows structure size as needed when offset+length exceeds current size. Default true. |
| `offset` | integer | For action='rename_field': field offset (in bytes) if renaming by offset. For action='field_xrefs': pagination offset (number of results to skip). |
| `field_length` | integer | For action='set_field'/'name_gap': explicit length in bytes. Required when the resolved data type has variable/unknown length. For name_gap, this is t |
| `field_name` | string | For action='set_field'/'name_gap': field name to apply at the target offset. For action='field_xrefs': field name to find references for (provide eith |
| `field_offset` | integer | For action='field_xrefs': field offset (in bytes) to find references for (provide either field_name or field_offset) |
| `instance_address` | string | For action='field_xrefs': optional base address of a struct instance to find instance-based references (in addition to type-based) |
| `size` | integer | For action='create' with name: initial struct size in bytes (default 0) |
| `c_definition` | string | For action='create' or 'modify': C-like struct definition. Prefer exactly one struct definition. Examples:   "struct Foo { int a; char b; };"   "typed |
| `name` | string | For action='create': structure name (required if c_definition is not provided) |
| `data_type` | string | For action='set_field': base data type name (e.g. "uint", "int", "MyStruct"). Must exist in the program DataTypeManager. |
| `comment` | string | For action='set_field'/'name_gap': optional field comment |
| `category` | string | For action='create': optional category path (e.g. "/mytypes" or "/auto_structs") |
| `allow_overwrite` | boolean | For action='name_gap': if false (default), refuses to overwrite any non-undefined bytes in the target range. |


### `types`

Data type operations: list, get, set, create_struct, create_enum, create_typedef, or delete

| param | type | description |
|---|---|---|
| `address` | string | Address (for set action) |
| `offset` | integer | Pagination offset (for list) |
| `values` | object | Enum values as name:value pairs (for create_enum) |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |
| `filter` | string | Name filter (for list) |
| `base_type` | string | Base type name (for create_typedef) |
| `array_count` | integer | For set action: wraps data_type in an array of this many elements |
| `size` | integer | Size in bytes (for create_struct/create_enum) |
| `limit` | integer | Pagination limit (for list, default 100) |
| `name` | string | Type name (for get/create/delete) |
| `data_type` | string | Data type name (for set action). Supports array suffix syntax like 'int[16]'. |
| `action*` | string | Operation to perform |
| `packed` | boolean | Enable packing (for create_struct) |
| `category` | string | Category path (optional) |


### `variables`

Variable operations: list, rename local/global variables, retype local variables, or set_prototype for function signatures

| param | type | description |
|---|---|---|
| `function_name_or_address` | string | Function name or address alias for local rename operations |
| `scope` | string | Rename scope for action='rename': auto, local, or global |
| `function_name` | string | Function name (required for list/rename/retype) |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |
| `data_type` | string | Data type string (required for retype) |
| `action*` | string | Operation to perform |
| `variable_name` | string | Variable name (required for rename/retype) |
| `address_or_name` | string | Global/data symbol address or current name for scope='global' |
| `function_address` | string | Function address (required for set_prototype) |
| `prototype` | string | Function prototype/signature string (required for set_prototype) |
| `var_name` | string | Alias for variable_name; for global rename this may be the current symbol name |
| `new_name` | string | New name (required for rename) |


### `xrefs`

Get cross-references to/from an address or function (direction: to, from, or both). Supports call graph traversal with depth parameter for function-based queries.

| param | type | description |
|---|---|---|
| `include_calls` | boolean | Optional: if true and function is specified, include recursive call graph (default false) |
| `depth` | integer | Optional: max call graph depth when include_calls is true (default 2, max 5) |
| `address` | string | Optional: address to find xrefs for (either address or function must be provided) |
| `function` | string | Optional: function name to find callers/callees xrefs for (either address or function must be provided) |
| `program_name` | string | Optional: Name or Ghidra project path of the program/binary to operate on. Use list_binaries and prefer the listed Project Path when multiple programs |
| `limit` | integer | Maximum number of references to return (default 100) |
| `direction` | string | Direction of cross-references to return |


## Prompts

- `identify_vulnerability` - Analyze a function for potential security vulnerabilities (buffer overflows, format strings, etc.)
- `compare_functions` - Compare two functions for similarity and differences
- `document_function` - Generate comprehensive documentation for a function including description, parameters, and usage
- `analyze_function` - Analyze a function comprehensively including decompilation, cross-references, and behavior
- `reverse_engineer_struct` - Reverse engineer a data structure from usage patterns
- `trace_network_data` - Trace network send/recv call stacks for POSIX and Winsock APIs to analyze protocol payload data structures and identify network-related vulnerabilities
- `trace_data_flow` - Trace data flow through a function, tracking how input data is transformed and used
