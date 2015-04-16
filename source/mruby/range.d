module mruby.range;

import mruby.value;
import mruby.mrb_class;
import mruby.object;
import mruby;

extern (C):

struct mrb_range_edges
{
	mrb_value beg;
	mrb_value end;
}

struct RRange
{
	enum mrb_vtype
	{
		MRB_TT_FALSE = 0,
		MRB_TT_FREE = 1,
		MRB_TT_TRUE = 2,
		MRB_TT_FIXNUM = 3,
		MRB_TT_SYMBOL = 4,
		MRB_TT_UNDEF = 5,
		MRB_TT_FLOAT = 6,
		MRB_TT_CPTR = 7,
		MRB_TT_OBJECT = 8,
		MRB_TT_CLASS = 9,
		MRB_TT_MODULE = 10,
		MRB_TT_ICLASS = 11,
		MRB_TT_SCLASS = 12,
		MRB_TT_PROC = 13,
		MRB_TT_ARRAY = 14,
		MRB_TT_HASH = 15,
		MRB_TT_STRING = 16,
		MRB_TT_RANGE = 17,
		MRB_TT_EXCEPTION = 18,
		MRB_TT_FILE = 19,
		MRB_TT_ENV = 20,
		MRB_TT_DATA = 21,
		MRB_TT_FIBER = 22,
		MRB_TT_MAXDEFINE = 23
	}
	mrb_vtype tt;
	uint color;
	uint flags;
	RClass* c;
	RBasic* gcnext;
	mrb_range_edges* edges;
	mrb_bool excl;
}

mrb_value mrb_range_new (mrb_state*, mrb_value, mrb_value, mrb_bool);
mrb_bool mrb_range_beg_len (mrb_state* mrb, mrb_value range, mrb_int* begp, mrb_int* lenp, mrb_int len);
mrb_value mrb_get_values_at (mrb_state* mrb, mrb_value obj, mrb_int olen, mrb_int argc, const(mrb_value)* argv, mrb_value function (mrb_state*, mrb_value, mrb_int) func);
