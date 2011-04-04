package
{
    import com.lib.playbook.app.TabletPagedApplication;
    import flash.events.Event;
    import flash.events.MouseEvent;

    import flash.display.Sprite;

    public class AppMenuDemo extends TabletPagedApplication
    {
        private var _menu:MenuBar;

        public function AppMenuDemo()
        {
            super();
            this.backgroundColor = 0x000000;
            this.backgroundAlpha = 0.75;

            initializeUI();
        }

        override protected function ShowApplicationBar( event : Event ):void
        {
            if(! _menu.isVisible())
            {
                _menu.show();
            }
        }

        public function initializeUI():void
        {
            var ground:Sprite = new Sprite();
            ground.graphics.beginFill(0x5CACEE, 1.0);
            ground.graphics.drawRect(0, 0, 1024, 600);
            ground.graphics.endFill();
            ground.addEventListener(MouseEvent.MOUSE_DOWN, groundClick);
            this.addChild(ground);
            _menu = new MenuBar();
            this.addChild(_menu);
        }

        private function groundClick(event : MouseEvent):void
        {
            if(_menu.isVisible())
            {
                _menu.processEvent(event);
            }
            else
            {
                // process the event in your main UI
            }
        }
    }
}
