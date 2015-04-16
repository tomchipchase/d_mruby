module mruby.mrb_debug;

import mruby.value;
import mruby;

extern (C):

enum mrb_debug_line_type
{
	mrb_debug_line_ary = 0,
	mrb_debug_line_flat_map = 1
}

struct mrb_irep_debug_info_line
{
	uint start_pos;
	ushort line;
}

struct mrb_irep_debug_info_file
{
	uint start_pos;
	const(char)* filename;
	mrb_sym filename_sym;
	uint line_entry_count;
	mrb_debug_line_type line_type;
	union
	{
		void* ptr;
		mrb_irep_debug_info_line* flat_map;
		ushort* ary;
	}
}

struct mrb_irep_debug_info
{
	uint pc_count;
	ushort flen;
	mrb_irep_debug_info_file** files;
}

const(char)* mrb_debug_get_filename (mrb_irep* irep, uint pc);
int mrb_debug_get_line (mrb_irep* irep, uint pc);
mrb_irep_debug_info_file* mrb_debug_info_append_file (mrb_state* mrb, mrb_irep* irep, uint start_pos, uint end_pos);
mrb_irep_debug_info* mrb_debug_info_alloc (mrb_state* mrb, mrb_irep* irep);
void mrb_debug_info_free (mrb_state* mrb, mrb_irep_debug_info* d);
