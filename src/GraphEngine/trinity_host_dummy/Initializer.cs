﻿using System;

namespace Trinity.Hosting
{
    public class Initializer
    {
        public static int Init()
        {
            Console.WriteLine("Hello from selfhost CLR!");
            Console.ReadKey();
            return 0;
        }
    }
}