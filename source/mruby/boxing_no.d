module mruby.boxing_no;

import mruby.value;

extern (C):

struct mrb_value
{
	union
	{
		mrb_float f;
		void* p;
		mrb_int i;
		mrb_sym sym;
	}
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
}
