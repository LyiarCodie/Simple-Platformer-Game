if (current_state == "Attack1")
{
	if (hor_dir != 0)
	{
		current_state = "Move";
	}
	else
	{
		current_state = "Idle";
	}
}
else if (current_state == "Attack2")
{
	if (hor_dir != 0)
	{
		current_state = "Move";
	}
	else
	{
		current_state = "Idle";
	}
}
else if (current_state == "Roll")
{
	if (hor_dir != 0)
	{
		current_state = "Move";
	}
	else
	{
		current_state = "Idle";
	}
}