
abstract class i_Lifecycle {
  void initState();
  
  void didChangeDependencies();
  
  void didUpdateWidgets<W>(W oldWidget);
  
  void deactivate();
  
  void dispose();
}