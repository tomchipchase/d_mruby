module mruby.irep;

import mruby.value;
import mruby;
import mruby.mrb_debug;
import mruby.compile;

extern (C):

enum irep_pool_type
{
	IREP_TT_STRING = 0,
	IREP_TT_FIXNUM = 1,
	IREP_TT_FLOAT = 2
}

struct mrb_locals
{
	mrb_sym name;
	ushort r;
}

struct mrb_irep
{
	ushort nlocals;
	ushort nregs;
	ubyte flags;
	mrb_code* iseq;
	mrb_value* pool;
	mrb_sym* syms;
	mrb_irep** reps;
	mrb_locals* lv;
	const(char)* filename;
	ushort* lines;
	mrb_irep_debug_info* debug_info;
	size_t ilen;
	size_t plen;
	size_t slen;
	size_t rlen;
	size_t refcnt;
}

mrb_irep* mrb_add_irep (mrb_state* mrb);
mrb_value mrb_load_irep (mrb_state*, const(ubyte)*);
mrb_value mrb_load_irep_cxt (mrb_state*, const(ubyte)*, mrbc_context*);
void mrb_irep_free (mrb_state*, mrb_irep*);
void mrb_irep_incref (mrb_state*, mrb_irep*);
void mrb_irep_decref (mrb_state*, mrb_irep*);
