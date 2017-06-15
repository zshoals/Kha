package kha.internal;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Expr.Field;

class VertexBufferBuilder {
	public static macro function build(): Array<Field> {
		var type = Context.toComplexType(Context.getType("kha.html5.graphics4.VertexBuffer"));
		switch (type) {
			case TPath(p):
			trace("Some TPath " + p.name);
			default:
			trace("Something else");
		}
		
		return null;
	}
}
