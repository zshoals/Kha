package kha.graphics4;

@:build(kha.internal.GraphicsBuilder.build("PipelineState"))
class PipelineState extends PipelineStateBase {
	public function new() { super(); }
	public function delete(): Void { }
	public function compile(): Void { }
	public function getConstantLocation(name: String): ConstantLocation { return null; }
	public function getTextureUnit(name: String): TextureUnit { return null; }
}
