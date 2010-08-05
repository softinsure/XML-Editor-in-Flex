package org.ludo.components.base
{
	import flash.xml.XMLNodeType;
	
	import mx.controls.Alert;
	import mx.controls.Tree;
	
	public class XmlTree extends Tree
	{
		[Embed("assets/text.png")]
		private var IconText:Class;
		
		[Embed("assets/comment.png")]
		private var IconComment:Class;

		[Embed("assets/element.png")]
		private var IconElement:Class;
		
		[Embed("assets/fopen.png")]
		private var IconOpen:Class;
		
		[Embed("assets/fclose.png")]
		private var IconClose:Class;

		[Embed("assets/plus.png")]
		private var IconPlus:Class;
		
		[Embed("assets/minus.png")]
		private var IconMinus:Class;
		
		private var mainXml:XML;
		//private var changedXml:XML;
		private var treeXml:XML;
		
		public var ineditor:Boolean=false;
		
		public function XmlTree()
		{
			super();
			this.selectable=true;
			//super.dataDescriptor=new XmlTreeDataDescriptor();
			this.setStyle("disclosureOpenIcon", IconMinus);
			this.setStyle("disclosureClosedIcon", IconPlus);
			this.labelFunction=tree_labelFunc;
			//this.editable=true;
		}
		private function tree_labelFunc(treeNode:XML):String 
		{
			if(treeNode.nodeKind()=='text')
			{
				this.setItemIcon(treeNode,IconText,IconText);
				return ineditor?'#text':treeNode.toString();
			}
			else if(treeNode.nodeKind()=='comment')
			{
				this.setItemIcon(treeNode,IconComment,IconComment);
				return ineditor?'#comment':treeNode.toString();
				//return '#comment';
			}
			else if(treeNode.nodeKind()=='element')
			{
				var expandNode:Boolean=false;
				if(treeNode.children().length()>1)
				{
					expandNode=true;
				}
				else if(treeNode.children().length()>0)
				{
					if(XML(treeNode.children()[0]).nodeKind()!='text')
					{
						expandNode=true;
					}
				}
				if(expandNode)
				{
					this.setItemIcon(treeNode,IconClose,IconOpen);
				}
				else
				{
					this.setItemIcon(treeNode,IconElement,IconElement);
				}
			}
			return treeNode.localName();
		}
		public override function set dataProvider(value:Object):void
		{
			if(value is XML)
			{
				treeXml=XML(value);
				mainXml=treeXml.copy();
				super.dataProvider=treeXml;
			}
		}
		public function undo():void
		{
			dataProvider=mainXml;
		}
		public function get changedXML():XML
		{
			return treeXml;
		}
	}
}