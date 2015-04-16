module mruby.error;

import mruby.mrb_class;
import mruby.object;
import mruby.value;
import mruby.variable;
import mruby;

extern (C):

struct RException
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
	iv_tbl* iv;
}

void mrb_sys_fail (mrb_state* mrb, const(char)* mesg);
mrb_value mrb_exc_new_str (mrb_state* mrb, RClass* c, mrb_value str);
mrb_value mrb_make_exception (mrb_state* mrb, int argc, const(mrb_value)* argv);
mrb_value mrb_exc_backtrace (mrb_state* mrb, mrb_value exc);
mrb_value mrb_get_backtrace (mrb_state* mrb);
void mrb_no_method_error (mrb_state* mrb, mrb_sym id, mrb_int argc, const(mrb_value)* argv, const(char)* fmt, ...);
mrb_value mrb_f_raise (mrb_state*, mrb_value);
