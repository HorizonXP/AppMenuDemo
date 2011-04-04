package
{
    import caurina.transitions.Tweener;

    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import qnx.ui.buttons.LabelButton;

    public class MenuBar extends Sprite
    {
        public static const WIDTH:int = 1024;
        public static const HEIGHT:int = 80;
        public static const VISIBLE_Y:int = 0;
        public static const HIDDEN_Y:int = -HEIGHT;
        public static const SLIDE_TIME:Number = 0.5;

        private var _active:Boolean;

        public function MenuBar()
        {
            initializeUI();
        }

        private function initializeUI():void
        {
            _active = false;

            // set default position (HIDDEN_Y)
            this.x = 0;
            this.y = HIDDEN_Y;

            this.graphics.beginFill(0x222222, 0.7);
            this.graphics.drawRect(0, 0, WIDTH, HEIGHT);
            this.graphics.endFill();

            var egButton:LabelButton = new LabelButton();
            egButton.label = "Example button";
            egButton.height = 64;
            // set the button in 10 pixels from the left, and center it
            // vertically in the menu bar
            egButton.x = 10;
            egButton.y = 6;
            egButton.addEventListener(MouseEvent.MOUSE_DOWN, handleEg);
            this.addChild(egButton);
        }

        public function isVisible():Boolean
        {
            return _active;
        }

        private function handleEg( event : MouseEvent ):void
        {
            hide();
        }

        public function show():void
        {
            _active = true;
            Tweener.addTween(this, {y:VISIBLE_Y, time:SLIDE_TIME,
                transition:"linear"});
        }

        public function hide():void
        {
            _active = false;
            Tweener.addTween(this, {y:HIDDEN_Y, time:SLIDE_TIME,
                transition:"linear"});
        }

        public function processEvent(event:MouseEvent):void
        {
            if(event.localY > HEIGHT)
            {
                hide();
            }
        }
    }
}

