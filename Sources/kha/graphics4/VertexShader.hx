package kha.graphics4;

import kha.Blob;

@:build(kha.internal.GraphicsBuilder.build("VertexShader"))
class VertexShader {
	public function new(sources: Array<Blob>, files: Array<String>) { }
	public function delete(): Void { }

	/**
	Beware: This function is not portable.
	**/
	public static function fromSource(source: String): VertexShader { return null; }
}
