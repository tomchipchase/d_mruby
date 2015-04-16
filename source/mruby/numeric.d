module mruby.numeric;

import mruby.value;
import mruby;

extern (C):

mrb_value mrb_flo_to_fixnum (mrb_state* mrb, mrb_value val);
mrb_value mrb_fixnum_to_str (mrb_state* mrb, mrb_value x, int base);
mrb_value mrb_float_to_str (mrb_state* mrb, mrb_value x, const(char)* fmt);
mrb_float mrb_to_flo (mrb_state* mrb, mrb_value x);
mrb_value mrb_fixnum_plus (mrb_state* mrb, mrb_value x, mrb_value y);
mrb_value mrb_fixnum_minus (mrb_state* mrb, mrb_value x, mrb_value y);
mrb_value mrb_fixnum_mul (mrb_state* mrb, mrb_value x, mrb_value y);
mrb_value mrb_num_div (mrb_state* mrb, mrb_value x, mrb_value y);
mrb_bool mrb_int_add_overflow (mrb_int augend, mrb_int addend, mrb_int* sum);
mrb_bool mrb_int_sub_overflow (mrb_int minuend, mrb_int subtrahend, mrb_int* difference);
