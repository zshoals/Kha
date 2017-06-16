package kha.internal;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Expr.Field;
import haxe.macro.Type;

class GraphicsBuilder {
	private static function findField(name: String, fields: Array<ClassField>) {
		for (field in fields) {
			if (field.name == name) {
				return field;
			}
		}
		return null;
	}

	private static function getInst(type: haxe.macro.Type) {
		switch (type) {
			case TInst(t, params):
				return t.get().fields.get();
			default:
		}
		return null;
	}

	macro static public function build(typeName: String): Array<Field> {
		var backend = "html5";
		var tt = Context.getType("kha." + backend + ".graphics4." + typeName);
		var type = haxe.macro.TypeTools.toComplexType(tt);
		var originalType = Context.getType("kha.graphics4." + typeName);

		var implFields = getInst(tt);

		var typePath = { name: typeName, pack:["kha", backend, "graphics4"], params:[] };
		var originalFields = Context.getBuildFields();
		var fields = new Array<Field>();
		for (field in originalFields) {
			var fieldname = field.name;
			switch (field.kind) {
				case FFun(f):
					if (field.name == "new") {
						var arguments = new Array<Expr>();
						for (arg in f.args) {
							var argName = arg.name;
							arguments.push(macro $i{argName});
						}
						var expr = macro {};
						if (haxe.macro.TypeTools.getClass(originalType).superClass != null) {
							expr = macro {
								super();
							}
						}
						expr = macro {
							$expr;
							$i{backend} = new $typePath($a{arguments});
						}
						fields.push({
							name: field.name,
							doc: field.doc,
							meta: field.meta,
							access: field.access,
							kind: FFun({
								ret: f.ret,
								params: f.params,
								expr: expr,
								args: f.args
							}),
							pos: field.pos
						});
					}
					else {
						var implField = findField(field.name, implFields);
						var self = false;
						// calling implField.expr() breaks everything
						/*switch (implField.expr().expr) {
							case TFunction(tfunc):
								trace("tfunc");
								self = tfunc.args.length > 0 && tfunc.args[0].v.t == originalType;
							default:
						}*/
						self = typeName == "PipelineState" && field.name == "compile";

						var arguments = new Array<Expr>();
						if (self) {
							arguments.push(macro this);
						}
						for (arg in f.args) {
							var argName = arg.name;
							arguments.push(macro $i{argName});
						}
						fields.push({
							name: field.name,
							doc: field.doc,
							meta: field.meta,
							access: field.access,
							kind: FFun({
								ret: f.ret,
								params: f.params,
								expr:
									field.access.indexOf(AStatic) < 0
									?
									macro {
										return $p{[backend, fieldname]}($a{arguments});
									}
									:
									macro {
										return $p{["kha", backend, "graphics4", typeName, fieldname]}($a{arguments});
									},
								args: f.args
							}),
							pos: field.pos
						});
					}
				default:
					fields.push(field);
			}
		}
		fields.push({
			name: backend,
			doc: null,
			meta: [],
			access: [APublic],
			kind: FVar(type, macro null),
			pos: Context.currentPos()
		});
		return fields;
	}
}
