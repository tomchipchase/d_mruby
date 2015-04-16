module mruby.mrb_class;

import mruby.object;
import mruby.variable;
import mruby.value;
import mruby.proc;
import mruby;

extern (C):

struct RClass
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
	kh_mt* mt;
	RClass* super_;
}

RClass* mrb_class (mrb_state* mrb, mrb_value v);
RClass* mrb_define_class_id (mrb_state*, mrb_sym, RClass*);
RClass* mrb_define_module_id (mrb_state*, mrb_sym);
RClass* mrb_vm_define_class (mrb_state*, mrb_value, mrb_value, mrb_sym);
RClass* mrb_vm_define_module (mrb_state*, mrb_value, mrb_sym);
void mrb_define_method_vm (mrb_state*, RClass*, mrb_sym, mrb_value);
void mrb_define_method_raw (mrb_state*, RClass*, mrb_sym, RProc*);
void mrb_define_method_id (mrb_state* mrb, RClass* c, mrb_sym mid, mrb_func_t func, mrb_aspec aspec);
void mrb_alias_method (mrb_state* mrb, RClass* c, mrb_sym a, mrb_sym b);
RClass* mrb_class_outer_module (mrb_state*, RClass*);
RProc* mrb_method_search_vm (mrb_state*, RClass**, mrb_sym);
RProc* mrb_method_search (mrb_state*, RClass*, mrb_sym);
RClass* mrb_class_real (RClass* cl);
void mrb_gc_mark_mt (mrb_state*, RClass*);
size_t mrb_gc_mark_mt_size (mrb_state*, RClass*);
void mrb_gc_free_mt (mrb_state*, RClass*);
