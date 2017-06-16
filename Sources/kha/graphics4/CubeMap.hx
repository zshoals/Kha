package kha.graphics4;

import haxe.io.Bytes;

@:build(kha.internal.GraphicsBuilder.build("CubeMap"))
class CubeMap implements Canvas implements Resource {
	public function new(size: Int, format: TextureFormat = null, depthStencil: DepthStencilFormat = NoDepthAndStencil, contextId: Int = 0) { }

	public function unload(): Void { }
	public function lock(level: Int = 0): Bytes { return null; }
	public function unlock(): Void { }

	public var width(get, null): Int;
	public var height(get, null): Int;

	private function get_width(): Int { return 0; }
	private function get_height(): Int { return 0; }

	public var g1(get, null): kha.graphics1.Graphics;
	public var g2(get, null): kha.graphics2.Graphics;
	public var g4(get, null): kha.graphics4.Graphics;

	private function get_g1(): kha.graphics1.Graphics { return null; }
	private function get_g2(): kha.graphics2.Graphics { return null; }
	private function get_g4(): kha.graphics4.Graphics { return null; }
}
