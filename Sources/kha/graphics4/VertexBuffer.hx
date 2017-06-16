package kha.graphics4;

import kha.arrays.Float32Array;

@:build(kha.internal.GraphicsBuilder.build("VertexBuffer"))
class VertexBuffer {
	public function new(vertexCount: Int, structure: VertexStructure, usage: Usage, instanceDataStepRate: Int = 0, canRead: Bool = false) { }
	public function delete(): Void { }
	public function lock(?start: Int, ?count: Int): Float32Array { return null; }
	public function unlock(): Void { }
	public function count(): Int { return 0; }
	public function stride(): Int { return 0; }
}
