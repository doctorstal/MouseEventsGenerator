package org.ds.mouse {
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author DoctorSTaL
	 */
	public class MouseManager {
		

		private var currMouseOveredObject:IMousePickable;
		private var objectUnderMouse:IMousePickable;
		
		private var currRollOveredObjects:Vector.<IMousePickable>;
		private var nextRollOveredObjects:Vector.<IMousePickable>;
		
		private var stage:InteractiveObject;
		
		private var picker:IObjectPicker;
		
		public function MouseManager(picker:IObjectPicker) {
			initPicker(picker);
		}
			
		private function initPicker(picker:IObjectPicker):void {
			this.picker = picker;
		}
		
		public function initStage(stage:InteractiveObject):void {
			stage = stage;
			stage.addEventListener(MouseEvent.CLICK, stage_clickHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			
			stage.addEventListener(Event.ENTER_FRAME, stage_enterFrameHandler);
		}
		public function dispose():void {
			releaseStage();
			releaseObjects();
		}
		private function releaseObjects():void {
			
			
		}
		private function releaseStage():void {
			stage.removeEventListener(MouseEvent.CLICK, stage_clickHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDownHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			
			stage.removeEventListener(Event.ENTER_FRAME, stage_enterFrameHandler);
			
			stage = null;
		}
		
		
		private function stage_clickHandler(event:MouseEvent):void {
			generateObjectUnderMouse(event);
			fireSameEvent(event);
		}
		
		private function stage_mouseMoveHandler(event:MouseEvent):void {
			/*generateObjectUnderMouse(event);
			fireMouseOverAndOutEvents(event);
			
			generateRollOveredObjects();
			fireRollOverAndOutEvents(event);
			
			fireSameEvent(event);
			
			currMouseOveredObject = objectUnderMouse;*/
		}
		private function stage_enterFrameHandler(event:Event):void {
			/*
			generateObjectsUnderPoint(event);
			generateMouseOverEvents(event);
			generateMouseOutEvents(event);*/
			
			//TODO mouseMove, mouseOver, mouseOut, rollOver, rollOut and other event triggers shoud be implemented here
		}
		
		private function stage_mouseDownHandler(event:MouseEvent):void {
			generateObjectUnderMouse(event);
			fireSameEvent(event);
		}
		
		private function stage_mouseUpHandler(event:MouseEvent):void {
			generateObjectUnderMouse(event);
			fireSameEvent(event);
		}
		
		private function fireMouseOverAndOutEvents(event:MouseEvent):void {
			if (objectUnderMouse != currMouseOveredObject) {
				if(objectUnderMouse!=null)
				objectUnderMouse.processEvent(
									changeEventParams(event, { type:MouseEvent.MOUSE_OVER, bubbles:true } ));
				if(currMouseOveredObject!=null)
				currMouseOveredObject.processEvent(
									changeEventParams(event, { type:MouseEvent.MOUSE_OUT, bubbles:true } ));
			}
		}
		
		private function fireRollOverAndOutEvents(event:MouseEvent):void {
			makeAndFireEvents(event, MouseEvent.ROLL_OVER, false, currRollOveredObjects, nextRollOveredObjects);
			makeAndFireEvents(event, MouseEvent.ROLL_OUT, false, nextRollOveredObjects, currRollOveredObjects);
		}
		
		private function makeAndFireEvents(event:MouseEvent, eventType:String, eventBubbles:Boolean, curr:Vector.<IMousePickable>, next:Vector.<IMousePickable>):void {
			if (curr == null || next == null) return;
			for (var i:int = 0; i < curr.length;i++){
				if (next.indexOf(curr[i]) == -1) {
					curr[i].processEvent(
											changeEventParams(event,{type:eventType,bubbles:eventBubbles}));
				}
			}
		}
		
		private function changeEventParams(event:MouseEvent,newParams:Object):MouseEvent {
			var newEvent:MouseEvent = new MouseEvent(newParams.type || event.type,
													newParams.bubbles || event.bubbles, 
													newParams.cancelable||event.cancelable, 
													newParams.localX||event.localX, 
													newParams.localY||event.localY, null, event.ctrlKey, event.altKey, event.shiftKey, event.buttonDown);
			return newEvent;
		}
		private function generateObjectUnderMouse(event:MouseEvent):void {
			objectUnderMouse = picker.getObjectUnderPoint(event.stageX, event.stageY);
		}
		private function generateRollOveredObjects():void {
			if(currMouseOveredObject!=null)
			currRollOveredObjects = currMouseOveredObject.getParentChain();
			if(objectUnderMouse!=null)
			nextRollOveredObjects=objectUnderMouse.getParentChain();
		}
		private function fireSameEvent(event:MouseEvent):void {
			if(objectUnderMouse!=null)
			objectUnderMouse.processEvent(event);
		}
	}

}