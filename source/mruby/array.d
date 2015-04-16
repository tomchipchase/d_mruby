module mruby.array;

extern (C):

import mruby.value;
import mruby.mrb_class;
import mruby.object;
import mruby;

struct mrb_shared_array
{
	int refcnt;
	mrb_int len;
	mrb_value* ptr;
}

struct RArray
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
	mrb_int len;
	union
	{
		mrb_int capa;
		mrb_shared_array* shared_;
	}
	mrb_value* ptr;
}

void mrb_ary_decref (mrb_state*, mrb_shared_array*);
void mrb_ary_modify (mrb_state*, RArray*);
mrb_value mrb_ary_new_capa (mrb_state*, mrb_int);
mrb_value mrb_ary_new (mrb_state* mrb);
mrb_value mrb_ary_new_from_values (mrb_state* mrb, mrb_int size, const(mrb_value)* vals);
mrb_value mrb_assoc_new (mrb_state* mrb, mrb_value car, mrb_value cdr);
void mrb_ary_concat (mrb_state*, mrb_value, mrb_value);
mrb_value mrb_ary_splat (mrb_state*, mrb_value);
void mrb_ary_push (mrb_state*, mrb_value, mrb_value);
mrb_value mrb_ary_pop (mrb_state* mrb, mrb_value ary);
mrb_value mrb_ary_ref (mrb_state* mrb, mrb_value ary, mrb_int n);
void mrb_ary_set (mrb_state* mrb, mrb_value ary, mrb_int n, mrb_value val);
void mrb_ary_replace (mrb_state* mrb, mrb_value a, mrb_value b);
mrb_value mrb_check_array_type (mrb_state* mrb, mrb_value self);
mrb_value mrb_ary_unshift (mrb_state* mrb, mrb_value self, mrb_value item);
mrb_value mrb_ary_entry (mrb_value ary, mrb_int offset);
mrb_value mrb_ary_shift (mrb_state* mrb, mrb_value self);
mrb_value mrb_ary_clear (mrb_state* mrb, mrb_value self);
mrb_value mrb_ary_join (mrb_state* mrb, mrb_value ary, mrb_value sep);
mrb_value mrb_ary_resize (mrb_state* mrb, mrb_value ary, mrb_int len);
mrb_int mrb_ary_len (mrb_state* mrb, mrb_value ary);
