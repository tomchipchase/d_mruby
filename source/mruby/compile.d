module mruby.compile;

import core.stdc.stdio;

import mruby.value;
import mruby.mrb_class;
import mruby;
import mruby.proc;

extern (C):

enum mrb_lex_state_enum
{
	EXPR_BEG = 0,
	EXPR_END = 1,
	EXPR_ENDARG = 2,
	EXPR_ENDFN = 3,
	EXPR_ARG = 4,
	EXPR_CMDARG = 5,
	EXPR_MID = 6,
	EXPR_FNAME = 7,
	EXPR_DOT = 8,
	EXPR_CLASS = 9,
	EXPR_VALUE = 10,
	EXPR_MAX_STATE = 11
}

enum mrb_string_type
{
	str_not_parsing = 0,
	str_squote = 1,
	str_dquote = 3,
	str_regexp = 7,
	str_sword = 41,
	str_dword = 43,
	str_ssym = 17,
	str_ssymbols = 49,
	str_dsymbols = 51,
	str_heredoc = 65,
	str_xquote = 131
}

struct mrbc_context
{
	mrb_sym* syms;
	int slen;
	char* filename;
	short lineno;
	int function (mrb_parser_state*) partial_hook;
	void* partial_data;
	RClass* target_class;
	mrb_bool capture_errors;
	mrb_bool dump_result;
	mrb_bool no_exec;
	mrb_bool keep_lv;
	mrb_bool no_optimize;
}

struct mrb_ast_node
{
	mrb_ast_node* car;
	mrb_ast_node* cdr;
	ushort lineno;
	ushort filename_index;
}

struct mrb_parser_message
{
	int lineno;
	int column;
	char* message;
}

struct mrb_parser_heredoc_info
{
	mrb_bool allow_indent;
	mrb_bool line_head;
	enum mrb_string_type
	{
		str_not_parsing = 0,
		str_squote = 1,
		str_dquote = 3,
		str_regexp = 7,
		str_sword = 41,
		str_dword = 43,
		str_ssym = 17,
		str_ssymbols = 49,
		str_dsymbols = 51,
		str_heredoc = 65,
		str_xquote = 131
	}
	mrb_string_type type;
	const(char)* term;
	int term_len;
	mrb_ast_node* doc;
}

struct mrb_parser_state
{
	mrb_state* mrb;
	mrb_pool* pool;
	mrb_ast_node* cells;
	const(char)* s;
	const(char)* send;
	FILE* f;
	mrbc_context* cxt;
	const(char)* filename;
	int lineno;
	int column;
	enum mrb_lex_state_enum
	{
		EXPR_BEG = 0,
		EXPR_END = 1,
		EXPR_ENDARG = 2,
		EXPR_ENDFN = 3,
		EXPR_ARG = 4,
		EXPR_CMDARG = 5,
		EXPR_MID = 6,
		EXPR_FNAME = 7,
		EXPR_DOT = 8,
		EXPR_CLASS = 9,
		EXPR_VALUE = 10,
		EXPR_MAX_STATE = 11
	}
	mrb_lex_state_enum lstate;
	mrb_ast_node* lex_strterm;
	uint cond_stack;
	uint cmdarg_stack;
	int paren_nest;
	int lpar_beg;
	int in_def;
	int in_single;
	mrb_bool cmd_start;
	mrb_ast_node* locals;
	mrb_ast_node* pb;
	char[1024] buf;
	int bidx;
	mrb_ast_node* all_heredocs;
	mrb_ast_node* heredocs_from_nextline;
	mrb_ast_node* parsing_heredoc;
	mrb_ast_node* lex_strterm_before_heredoc;
	mrb_bool heredoc_end_now;
	void* ylval;
	size_t nerr;
	size_t nwarn;
	mrb_ast_node* tree;
	mrb_bool no_optimize;
	mrb_bool capture_errors;
	mrb_parser_message[10] error_buffer;
	mrb_parser_message[10] warn_buffer;
	mrb_sym* filename_table;
	size_t filename_table_length;
	int current_filename_index;
	mrb_jmpbuf* jmp;
}

struct mrb_jmpbuf;


mrbc_context* mrbc_context_new (mrb_state* mrb);
void mrbc_context_free (mrb_state* mrb, mrbc_context* cxt);
const(char)* mrbc_filename (mrb_state* mrb, mrbc_context* c, const(char)* s);
void mrbc_partial_hook (mrb_state* mrb, mrbc_context* c, int function (mrb_parser_state*) partial_hook, void* data);
mrb_value mrb_toplevel_run_keep (mrb_state*, RProc*, uint);
mrb_parser_state* mrb_parser_new (mrb_state*);
void mrb_parser_free (mrb_parser_state*);
void mrb_parser_parse (mrb_parser_state*, mrbc_context*);
void mrb_parser_set_filename (mrb_parser_state*, const(char)*);
const(char)* mrb_parser_get_filename (mrb_parser_state*, ushort idx);
mrb_parser_state* mrb_parse_file (mrb_state*, FILE*, mrbc_context*);
mrb_parser_state* mrb_parse_string (mrb_state*, const(char)*, mrbc_context*);
mrb_parser_state* mrb_parse_nstring (mrb_state*, const(char)*, int, mrbc_context*);
RProc* mrb_generate_code (mrb_state*, mrb_parser_state*);
mrb_value mrb_load_file (mrb_state*, FILE*);
mrb_value mrb_load_string (mrb_state* mrb, const(char)* s);
mrb_value mrb_load_nstring (mrb_state* mrb, const(char)* s, int len);
mrb_value mrb_load_file_cxt (mrb_state*, FILE*, mrbc_context* cxt);
mrb_value mrb_load_string_cxt (mrb_state* mrb, const(char)* s, mrbc_context* cxt);
mrb_value mrb_load_nstring_cxt (mrb_state* mrb, const(char)* s, int len, mrbc_context* cxt);
