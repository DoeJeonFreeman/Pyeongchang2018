package components {
	
	import flash.events.Event;
	import mx.controls.CheckBox;
	/**
	* Creates a Master / Subordinate relationship for a group of checkboxes.
	* The Master checkbox is a ’select all’ box: when it is selected, all
	* of the subordinates are selected; when it is de-selected, all of the subordinates
	* are de-selected. The subordinates have the corresponding effect on the
	* master: if the user de-selects one of the subordinates, the master is also de-selected.
	* If the user’s selection of a subordinate results in all of the subordinates being selected,
	* then the master is also selected.An optional “other” checkbox provides functionality
	* for “none of the above” / “other” options. If this parameter is supplied, and the user
	* selects this checkbox, it de-selects all other checkboxes in the group.
	*/
	public class CheckBoxGroup {
		/**
		* Constructor
		* @param master Checkbox that controls the other checkboxes in the group
		* @param subs Array of checkboxes that are subordinate to the master
		*/
		public function CheckBoxGroup(subs:Array,master:CheckBox=null, other:CheckBox=null){
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
		protected function testSubs(): void {
			for(var i:String in _subs) {
				if(!(_subs[i] is CheckBox)) {
					throw new Error(”The array provided to the ” +
					“CheckBoxGroup constructor must ” +
					“contain only CheckBox instances.”);
				}
			}
		}
		
		/**
		* Stores current state (selected / not selected) of the CheckBox instances
		*/
		protected function storeStates():void {
			_masterSelected = _master?_master.selected:false;
			for(var i:int = 0; i < _subs.length; i++) {
				_subsSelected[i] = _subs[i].selected as Boolean;
			}
		}
		
		/**
		* Assigns event listeners to the master and subordinate checkboxes
		*/
		protected function addEventListeners(): void {
			if(_master){
				_master.addEventListener(Event.CHANGE, selectAll);
			}
			for each(var checkbox:CheckBox in _subs) {
				checkbox.addEventListener(Event.CHANGE, selectSome);
			}
			if(_other){
				_other.addEventListener(Event.CHANGE, selectNone);
			}
		}
		
		/**
		* Handles Master checkbox change events. When the master is selected,
		* it selects all subordinates. When the master is de-selected, it
		* de-selects all subordinates.
		*/
		protected function selectAll(event:Event): void	{
			var selected:Boolean = event.target.selected as Boolean;
			for each(var checkbox:CheckBox in _subs){
				checkbox.selected = selected;
			}
			if(selected && _other){
			/** deselect the none checkbox*/
				_other.selected = false;
			}
		}
		
		/**
		* Handles Subordinate checkbox change events. If all subordinates
		* are selected, this function selects the master; otherwise, it
		* de-selects the master.
		*/
		protected function selectSome(event:Event):void{
			if(_master){
				_master.removeEventListener(Event.CHANGE, selectAll);
				_master.selected = allSelected;
				_master.addEventListener(Event.CHANGE, selectAll);
				if(_master.selected && _other) {
					/**
					* Deselect the none checkbox
					* if master is selected
					* and _other chkbox exists
					*/
					_other.selected = false;
				}
			} else {
				/** we dont have a master */
				if(countSelected == 1){
				_subs.forEach(disableSelectedSubs);
				} else {
				_subs.forEach(enableAllSubs);
				}
			}
		}
		
		
		private function disableSelectedSubs(cb:CheckBox, index:int, array:Array):void{
			cb.enabled = !cb.selected;
		}
		
		private function enableAllSubs(cb:CheckBox, index:int, array:Array):void{
			cb.enabled = true;
		}
		
		private function checkAllSubs(cb:CheckBox, index:int, array:Array):void{
			cb.selected = true;
		}
		
		private function uncheckAllSubs(cb:CheckBox, index:int, array:Array):void{
			cb.selected = false;
		}
		
		
		/**
		* Handles Other checkbox change events. When the “other” checkbox is selected,
		* this function de-selects all other checkboxes in the group. When the “other”
		* checkbox is de-selected, all other checkboxes in the group are returned to
		* their most recent state.
		*/
		protected function selectNone(event:Event): void {
			if(event.target.selected){
				_master.selected = false;
				storeStates();
				if(!_masterSelected){
				_subs.forEach(uncheckAllSubs);
				}
			} else if(!_master.selected){
				_master.selected = _masterSelected;
				for(var i:int = 0; i < _subsSelected.length; i++){
					_subs[i].selected = _subsSelected[i];
				}
			}
		}
		
		
		/**
		* Read Only
		*/
		private var _countSelected:uint;
		
		private function get countSelected():uint{
			_countSelected = 0;
			for each(var checkbox:CheckBox in _subs){
				if(checkbox.selected){
					_countSelected++;
				}
			}
			return _countSelected;
		}
		
		
		/**
		* Checks to see whether all subordinates are selected. Returns
		* true if all are selected, false if one or more are not selected.
		* Read Only
		*/
		private var _allSelected:Boolean;
		
		public function get allSelected():Boolean {
			for each(var checkbox:CheckBox in _subs){
				if(checkbox.selected){
					continue;
				}
				_allSelected = false;
				break;
			}
			return _allSelected;
		}
		
		
		/** Atleast minSelections of _subs checkbox should be selected at anytime*/
		private var _minSelections:uint = 1;
		
		public function get minSelections():uint{
			return _minSelections;
		}
		
		
		public function set minSelections(value:uint):void{
			_minSelections = value;
		}
		
		
		/** Master checkbox*/
		private var _master:CheckBox;
		
		/** Subordinate checkboxes*/
		private var _subs:Array = [];
		
		/** Other checkbox*/
		private var _other:CheckBox;
		
		/** Boolean and arrays to store most recent states*/
		private var _masterSelected:Boolean;
		
		private var _subsSelected:Array = [];


	}//class


}//pac
