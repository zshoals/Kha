package kha.internal;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Expr.Field;

class GraphicsBuilder {
	private static function createTypedef(backend: String, name: String): Void {
		trace("Creating " + name);
		Context.defineType({
			pos: Context.currentPos(),
			params: [],
			pack: ["kha", "graphics4"],
			name: name,
			fields: [],
			isExtern: false,
			meta: [],
			kind: TDAlias(
				Context.toComplexType(Context.getType("kha." + backend + ".graphics4." + name))
			)
		});
	}

	public static macro function build(backend: String): Array<Field> {
		createTypedef(backend, "VertexBuffer");
		createTypedef(backend, "FragmentShader");
		createTypedef(backend, "IndexBuffer");
		createTypedef(backend, "VertexShader");
		createTypedef(backend, "PipelineState");
		createTypedef(backend, "CubeMap");
		return null;
	}
}
