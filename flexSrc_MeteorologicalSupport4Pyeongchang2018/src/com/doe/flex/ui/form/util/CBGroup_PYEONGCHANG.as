package com.doe.flex.ui.form.util 
{
	
	import flash.events.Event;
	
	import mx.core.Application;
	
	public class CBGroup_PYEONGCHANG 
	{
		
		/**
		 * Constructor
		 * @param master Checkbox that controls the other checkboxes in the group
		 * @param subs Array of checkboxes that are subordinate to the master
		 */
		public function CBGroup_PYEONGCHANG(master:ImageCheckBox, subs:Array, other:ImageCheckBox=null)
		{
			this._master = master;
			this._subs = subs;
			this._other = other;
			testSubs();
			storeStates();
			addEventListeners();
		}
		
		/**
		 * Ensures that the array of subordinates includes only CheckBox instances
		 */
		protected function testSubs(): void
		{
			for(var i:String in _subs)
			{
				if(!(_subs[i] is ImageCheckBox))
				{	trace('instanceOf(imageCheckBox) ==false')
					throw new Error("The array provided to the CheckBoxGroup constructor must contain only CheckBox instances.");
				}
			}
		}
		
		/**
		 * Stores current state (selected / not selected) of the CheckBox instances
		 */
		protected function storeStates(): void
		{
			_masterSelected = _master.selected;
			for(var i:int = 0; i < _subs.length; i++)
			{
				var selected:Boolean = _subs[i].selected;
				_subsSelected[i] = selected;
			}
		}
		
		/**
		 * Assigns event listeners to the master and subordinate checkboxes
		 */
		protected function addEventListeners(): void
		{
			_master.addEventListener(Event.CHANGE, selectAll);
			for each(var checkbox:ImageCheckBox in _subs)
			{
				checkbox.addEventListener(Event.CHANGE, selectSome);
			}
			if(_other != null) _other.addEventListener(Event.CHANGE, selectNone);
		}
		
		/**
		 * Handles Master checkbox change events. When the master is selected, 
		 * it selects all subordinates. When the master is de-selected, it 
		 * de-selects all subordinates. 
		 */
		protected function selectAll(event:Event): void
		{
			var selected:Boolean = event.target.selected;
			for each(var checkbox:ImageCheckBox in _subs) 
			{
				checkbox.selected = selected;
			} 
			if(selected && _other != null){
				_other.selected = false;
			} 
			mx.core.Application.application.DJFShowDataTipMan('cb_all', event.currentTarget.selected);
			
		}
		
		/**
		 * Handles Subordinate checkbox change events. If all subordinates
		 * are selected, this function selects the master; otherwise, it
		 * de-selects the master.
		 */
		protected function selectSome(event:Event): void
		{
			_master.removeEventListener(Event.CHANGE, selectAll);
			_master.selected = allSelected();
			_master.addEventListener(Event.CHANGE, selectAll);
			if(_master.selected && _other != null){
				_other.selected = false;
			} 
			
			//			selectNone(event);
			for each(var checkbox:ImageCheckBox in _subs){
				if(checkbox.id != event.currentTarget.id){
					checkbox.selected = false;
				}
				//				else{
				//					mx.core.Application.application.prevModelName = event.currentTarget.label;
				//				}
			}
			
//			CommonUtil.getInstance().showAlertDialogOnScreenTop('selectedItem id is: '+event.currentTarget.id,'CBGroup_PYEONGCHANG.selectSome() ');
			
			if(event.currentTarget.selected){
//				mx.core.Application.application._legendItem_prevSelection = event.currentTarget.id; //BEST_MERG 2016
			}else{
//				mx.core.Application.application._legendItem_prevSelection = null;
			}
			
			
/*			
//			if(event.currentTarget.selected){
				var currTargetLabel:String = event.currentTarget.label; //BEST_MERG 2016 
				currTargetLabel = (currTargetLabel=="RDPS MOS")? "PMOS" : currTargetLabel; //BEST_MERG 2016
				mx.core.Application.application._prevModelName = currTargetLabel; //BEST_MERG 2016
				mx.core.Application.application.setBasedOnStr(currTargetLabel); //BEST_MERG 2016
				//				mx.core.Application.application._prevModelName = event.currentTarget.label;
				//				mx.core.Application.application.setBasedOnStr(event.currentTarget.label);
				mx.core.Application.application.lbl_baseModel.alpha = 1.0;
			}else{
				mx.core.Application.application._prevModelName = '';
				//				mx.core.Application.application.setBasedOnStr(null);
				mx.core.Application.application.lbl_baseModel.alpha = 0.1;
				
			}
*/
			
			//  아주 tightly coplued 여 ㅠ 일단 일케 가봐
			mx.core.Application.application.DJFShowDataTipMan(event.currentTarget.id, event.currentTarget.selected);
		}
		
		/**
		 * Handles Other checkbox change events. When the "other" checkbox is selected,
		 * this function de-selects all other checkboxes in the group. When the "other"
		 * checkbox is de-selected, all other checkboxes in the group are returned to
		 * their most recent state.
		 */
		protected function selectNone(event:Event): void 
		{
			var selected:Boolean = event.target.selected;
			if(selected)
			{
				storeStates();
				_master.selected = false;
				if(!_masterSelected)
				{
					for each(var checkbox:ImageCheckBox in _subs)
					{
						checkbox.selected = false
					}
				}
			}
			else if(!_master.selected)
			{
				_master.selected = _masterSelected;
				for(var i:int = 0; i < _subsSelected.length; i++)
				{
					_subs[i].selected = _subsSelected[i];
				}
			}
			
			
		}
		
		/**
		 * Checks to see whether all subordinates are selected. Returns 
		 * true if all are selected, false if one or more are not selected.
		 */
		protected function allSelected(): Boolean
		{
			var allSelected:Boolean = true;
			for each(var checkbox:ImageCheckBox in _subs)
			{
				if(!checkbox.selected)
				{
					allSelected = false;
					break;
				}
			}
			return allSelected;
		}
		
		// Master checkbox
		private var _master:CheckBox;
		// Subordinate checkboxes
		private var _subs:Array = [];
		// Other checkbox
		private var _other:CheckBox;
		// Boolean and arrays to store most recent states
		private var _masterSelected:Boolean;
		private var _subsSelected:Array = [];
	}
}