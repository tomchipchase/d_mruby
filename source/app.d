import std.stdio;

import mruby;
import mruby.compile;
import mruby.value;
import mruby.data;
import mruby.mrb_class;
import std.string;

extern(C) {
	mrb_value foo(mrb_state *mrb, mrb_value self)
	{
		writeln("Hello, World!");
		return self;
	}
}

void main()
{
	auto mrb = mrb_open;
	auto Foo = mrb_define_class(mrb, "Foo", mrb.object_class);

	mrb_define_method(mrb, Foo, "foo", &foo, MRB_ARGS_NONE());

	auto code = "Foo.new.foo";
	writeln("Executing Ruby code from D!");
	mrb_load_string(mrb, code.toStringz);
}
