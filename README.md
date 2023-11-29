# Unit Testing para C++
Este proyecto consiste en unas herramientas que permiten realizar test unitarios sobre programas escritos en C++.

En el directorio se puede encontrar una carpeta llamada `test` en la que irán la libreria de testeo y todos los test; estos test implementarán la clase descrita en el fichero `Test.h` y que deberan terminar con Test.cpp; por ejemplo, un test para una **clase llamada Reloj se llamaría RelojTest.cpp**.

Tambien se pueden encontrar un fichero `test.sh`, este fichero es el encargado de ejecutar los test unitarios dentro de una terminal. Para ejecutar todos los test hay que ejecutar el comando:

```
./test.sh
```

Estas herramientas tienen dos dependencias: `dos2unix` y `tree`, la primera se utiliza para sustituir los saltos de linea de Windows por los de Linux en caso de que se programe desde un sistema con Windows ya que sino el script `test.sh` no funcionará; y el segundo permite al script recorrer todos los directorios en busca de ficheros que compilar; para instalarlos se puede ejecutar el comando:
```
sudo apt install dos2unix
sudo apt install tree
```

### Testing
Para realizar los testeos las clases que implementarán los test unitarios deben heredar de la clase Test antes mencionada; aquí hay un ejemplo de test unitario.
```cpp
/* AQUÍ VAN LAS IMPORTACIONES */
#include <stdio.h>
#include "Test.h"

using namespace std;

/* ESTA ES LA CLASE DE TEST QUE HEREDA DE TEST */
class ExampleTest: public Test{
    public:
        using Test::Test;   // HEREDAMOS EL CONSTRUCTOR

        /* ESTE METODO SE ENCARGA DE EJECUTAR TODAS LAS ASSERCIONES */
        void execute(){
            /* AQUÍ HAY QUE IR INCLUYENDO LOS DIFERETES TEST UNITARIOS */
            assert(unitTestExample);
        }

        /* ESTO ES LA ESPECIFICACIÓN DE UN TEST UNITARIO */
        static bool unitTestExample();
};

/* ESTA ES LA IMPLEMENTACIÓN DEL TEST UNITARIO */
bool ExampleTest::unitTestExample2(){
    /* AQUÍ VAN TODAS LAS COMPROBACIONES NECESARIAS */
    return true;
}

/* ESTA PARTE EJECUTA EL TEST */
int main(int argc, char** argv){
    ExampleTest *test = new ExampleTest(argv[1]);

    /* ESTO EJECUTA TODOS LOS TEST */
    test->assertAll();

    return test->no_passes;
}
```

### Testeo
Una vez hemos ejecutado el comando `./test.sh` se nos generará un fichero `test.log` que contiene un texto formateado con el resultado del testeo, este fichero se visualizará automaticamente pero quedará almacenado en la raiz del proyecto para facilitar la corrección del codigo.

Si en algún momento se desea volver a ver el log basta con ejecutar
```
cat test.log
```

En este output se pueden leer rapidamente el nombre de los fichero y ver si ha ocurrido algun error y en caso de que los hubiese en que numero de test unitario ha ocurrido.

Tambien se pueden observar el numero de checks verdes y rojos a la izquierda del nombre del fichero.

![Image](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAe0AAABzCAIAAAA6zc0rAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAShElEQVR42u2dS27cOhaG7wJKsg0DHRgIkEnP7qiR9Ba8ggCeZREB7FUEyKBWkGlmtYjboyyqJfEhPg8pucR6fT8MpKKiDilW1cejQ+rwr4+f/v2fz//dobXqvnb/+t9O/T1+7egQhFBj/QXHEUIIjiOEEILjCCGETsjx7mX/5/D2pSM6jBBCJ+K44rD7xpe3w5/9y7E43o3m/liDnTnhiFcy2dRyr6XTdU+qu6LONte5IsdKWMUiO7l2FkwpS04nz1aq7Tg1z6ckr6sLjup3uhX97zXVaX+u/IrrQgiOjxyPqb0Bxw+DFAu24PhgceClrctUpP8TvC7B7vD2to85vggrOTvJdtaMB/t9upMVEJVNQROZ5+q+vO3Va/mDjgf4Rf2vuTw1W49qpq5iP1ReF0JI4rj9ASf9qcB1quD4/uVlb5A6c9zzlw3ygt92PfJCdqt6rQ9YHG/GE8byhiFVHNeX4DmbWTvJdubszAgeDuYbX6StwMRjcTzd//6AnfwchfF1Re0I3S7Hu8k7cmllf0IKADO4U6/r/PEBI8oJ6+zPO/gNm5959nh9gEX7ej5GA6yXvOn1HBfsCGxN2rHsy3VyzUUJZTbgeLr/7XgdDCe5Mab+w0IIjhuOj4wY7rZV8MMSN/anPBAv5HinaDgzKfCXHbMB0+vvr+2NfMiUVLR6Eccrbz4qOe62U74c7dtGnWzvh+qCRXmOOwr6eQXHvf5X5+s69Ku4itXXhRCKOD4FA6bgh+F4Zr5rcbzCHQC0+YSP6SJ7HkqW+GVBFHjnTdkd3l7W++MrECzYiduZPT1gYm5IECczChw/nj8eXJeZy/RiaC7H5X4oXhdCyOG4iV+Pv/WRtC/ab85MSAZsLcY93PITnsv+uCnZ2ZjPCogncFa5ZEXkuPxusWQlxHfBDETGZa4aR5vEx3ODqK03iI9XfV6sZ0VoCccPh8McM7FrS5I+kTeXpWBTzfFpCnCfjI8Hfm6nkV+3qMOcvA7N9YWDdRe7hfFxoZ2CHQFqcXvyQ8KG61Vy1+V+puGcivx51V0XQshwvLM/c7M+LL2exPkd2sPiUooEx0P7/qrmrqvkWuxvRm5rt8svtql2gdXYFobHi/zN2Mm2cxHH5faI/nLV+vGlHBeuK7l+P1d+3XUhBMd5Lh8hhOA4QgghOI4QQgiOI4QQHEcIIQTHEUIInZLj3d/9w4++5+GLvPrX/uEb/dNUXXf//f7j97P/Ws4LJ1n5jk7F8a7rHn71D8/dBr/D0fLj9FcDwaH8/Q9dfvjr9WLk8aBqni7QfMgZx7lfTSv92n/65276u//wWc6H1X34ff/pn/7R/Pfxp2HfxEFr5+lreUl+orw6+LN3DJaadMye759qWh7y9BRL0SvTPq/I8y6I9JBwfHNPc7Ss+Dtx8P7vrgzxV12m/6Z57XLcHmztjH9r6oyPEJ9YqblpGJ3n+MffM7s1x4NzP/cfZf7myrscLxrZQmOlYg8sJelpOX5cBMNxON7O09QsFlHYPc8+uOuGzy+aO8XuXYU8CB21utmhtpj+LvF3KPD0tX/63d97HPc9WRfHNZ6vLe+8mCo6Qf97HbKUpPaBWQs+93la5xlT8zDqmBniTfnMU1Ig+9CzSUiUcaKTtQuPFicRnNlHyfPhVe6ahFtPVOdmOT56uK9dGxTKoZu4JepGwXLceuXtnfEGXZTkqY6Z3In81XgdYDeeZakXu7GDm69YX+n2qvKG44VhYOsbFKHlRY94zuceJe2y+bzmPYwM6U3aCpu384uBu5djWag9l7s/x/FcecHTxx+H41Vu8rECLMV4yFgmz/HKCPtWdxLPjTn+4bMi+Ejkkh9t3OQBxBN2NcfH4MwSjufK26B5DUk3DK1UxHOEvOoTdvf7/CZ/8zYnYV5ObxCY8zhGaUED2uby+OcQLJQ3GSTXbAuFbobjG0Nq9Gcr4hJFf3yjydgCVZ9bR+RHjt8pgndV8RDD8YngA+w28scHsyfzx83YVsHxjN+a33cpTLN/NI6X5jNDjovlc0ti4Dgcb+GPV0I8JqYNxczx8edaU8e9k2h8H6BiKZaYtfHxqcBA3gm4Nj4+s2+ifDE+nig/x8fHAqdZBVg51SlwfI5tz/kXvfzJi/3xyL+W/fGiK12zEXmc1xeOw/G0F3xkZ7aavBrcBpo2FBOuV2k41XmqmVW7XiUZ7hA4Pr7un8x6lRHE1gF3bWbspMtH61VOMNX53vi4yQjv7/kXvl7E8TjeLcfHa0IiNXshBbUs2sYWXS3Ht0OVu3g8WBJedcqP/PrxVmxtPMPp9IOzjrvkh/ocV+u73TWItevQc+VT68ebonzZepVo/bidt3SY7m4J7ez/V8HxRFL+OCCSe6sUEkmWDw8m8/WzXuXGOb7jSUVxUGkcxkGrgyrbfx+W7f2NUFOOb/c8J0LvpeeS5znhOLpdju/Ir3JDNxlO5MT9OwOHN9XaM8qvAsfRuXMcIYQQHEcIIQTHEUIIreM48fGiWNXTXpvGxyvj3XYZonvWFSzZPocHiMjbfkyOb7peZXycx18PLv60yD+u+mGejSw+/0L+8WvieBu8Bg+jXmTe9rXov5r8703zj7vPZMrP1JB/3Gp6vN7mOyw4pOQfb8nx63CTv0zPPC0l6Rlw3OQWPsZoeun535s+z2mfoyluJUH+8RxbZZec/OMBmoN8h2FeFJtHRR+3p4RJrOJHKHNxAIVF11DCTvAcplOBKi/kE/evy/Oj43qD3LzBf3cVGb5cv/V88rYH9xDudeX6J/l9kBF8QfnfG+VXcbmsEPwoRm/IP54LsMhZBsk/XuCRyHH/GX2NAC+dVuSPx7VoQzO1NF9y+cQ7k+y8xr8L8nm5CVWS9SbKl/LAXETe9pDjUePS/bM2v835539vlO9Q5y80BB/8WRnE5B9P8qtuf07yj1uehnm6S/54mIc2zANeyXHrNubsOBgSfvwJjof8ms0m6xWuMRdNuoi87VmOy/2Tydu+u/z8743yjyt/3OY7LNZF/vEUvMrxBPKPp5HkByUWcDzgQiXHM3GJeD5NjssnOJ6aaJ1926Qf7V5LHM+JwsoXkbc9y/F8/+zEJTGXnv+9lT8+eeKWvFXxcfKPL4T4jvzjAn2cfIGrOV4TB8jEc9L5xIM4wHv9cfF+P5jPzHHnIvK25+LjQv8kvw+V/njxe3VGHN86+Otu5xaHTeIIBvnHHaTWEpP848VYuR9j/ZPk+FzG4VTnTNetiC/n8okL9+nxsBFw08ajC370dNLh4NUSM7QQHz+nvO3+ehUdjJf7p1jLRed/b7ReZResB3+tcS3JP55KZSWik/zjnq+UytPduXfFJtQgJAfv3CUg0bxofEo+vpGtwn3D9woT+cS7YHWLe68gx0PqxpuLyNseHQtW4ETrW8S87bvLz/9O/vHaQYj84+egM8k/fmnf3niGsxw3aNMStAnHyT+OzpdHZ5N//LJ0Pvu9wfFGHN+RX+WG3DTyj98Awf3HYeD4rXAcIYQQHEcIIQTHEUIIwXGELlftMwOftl4ExxF6l8YVjc5k7wkTyJwtx1c8gXUUHavepXZO8oQEHEfofRxnZXoTnl4Ex/Vz1Bey1BWOIyRxXGWOtN66BUHueG7fpVz58v2B0yo3T9lkv7iviJdh2KbNEewk6w1uVoJ3x7QNddcb7IVS3Bqlul43F5DT/3dODokli2snI1O+OTiO0HVw3JLC5U7yeLDXh5tiN2dnUauCXAvFewiZ44KdpOWkPzuUtPbdvD21/VNxD5Ss102t7L4WbK7w6+E4QpfG8bvQjwtY7GZ3SR4Ptkkqll/H8ZjLa/3xrJ16jkfUczieut5cGxZxPOhAt9uF9G1wHKEb9serj0f5fv30kMvj7+fPcb21910Y4shdrz/mVU3hpjjuV1oRGoLjCMHxOo7L/vjVcTyIk4T+uBjfUAH0mk4o+uPCtQfxdDiOEBwvctzjWhgvbs7xnRM71j7sOzge76jnbkii0/VUXK8Kl9fv053cyS/eerDYe5U7AsJxhC6Z46n140v5nsvzvojjwaILGyJYwfE5BDHySIcyCvOfmXUd3rvm+HiujWz0c6hE5HjoKS/oDVtv0FSnf+Igj2BHGv+q8/7DcYTQbal+hhPBcYTQud768NA/HEcIXSrB7z6xGQgcRwghBMcRQgiOI4QQguMIIUnkH0dwHKEFIv94sd7bylvrPAdwDl8GOI5QHcfJP96EpxfB8aGweU61NjklHEfoTDlO/vHd7eUfj/vwzF1yOI5QgePkHxf82evOP77zc8jAcYTOnuPkH1/Oca+6q8s/HgxOcByhi/XHyT+e5+B15x+fRoVzD47DcYSOynHyj19R/vFLgTgcR+i4HCf/+JXkH5/65DIgDscR2oU34+Qfv/n8496HSP5xhBCSoz0IjiOELvDWh4f+4ThC6FIJTv5xOI4QQgiOI4QQHEcIIQTHEUIIwXGEEEJwHCGE4DhCCCE4jhBCCI4jhBAcRwghBMcRQgjBcYQQQnAcIYTgOEIIITiOEEIIjiOEEILjCCEExxFCCMFxhBBCLTje/d0//Oh7NtDLq3/tH77RP001bbL+8fs2X8uu+/J2+LN/KRjvXvZ/Dm9fTBvUWe6RC5W6rNO2YerKSfsXvu3v5XjXdQ+/+ofnrb6X4yDxq3+sGCeGltz/6B9/6T9VXh1UzdMFmg856hJaVvq1/zTuTjtuUFvYZbzrPvy+//RP/2j++/jTsG/ioLVT3ug2WV4d/Nk7BhtufN71Txtt0XueHG+DV3PpXcjTSY35rtpS1+ZA48dw1D45mv0Gn2PI8U09TU3h1zJ8NaNfdZn+mz7F5bg92NoZ/9bUGR8hPrFSc9MwOs/xj79ndmuOB+eO25aL/M2VdzleNLKFxkrFHmjJ8etwk4crd2upJOlpOd6si45ivzXHt/Y0NXmfKzj+PPvgrhs+v2juFLv3K/d/t/JAHYfaYvq7xN+hwNPX/ul3f+9x3PdkXRzXeL62vPNiqugE/e91SBHNVorRAa8tl81xe4rnfA2lfLesE+IACouuoYQdfzDonApU+YQ7aGrxr8vzo+N6p7LztQT/nazpLpBJam88nAuZq3aarw+OVvdvqi37F/W+6mhl3p4ROrnJ2nP9lkTk0v5Pfk9kBNfbET7HDTk+cvZ124jKQMCuguNxS9SNguW49crbO+PbdZHMUx0zuRP5q/E6wG48y1IvdmMHN1+xvtLtVeUNxwvDwNY3KELLCzwSOT7jfvylaiSplzl/PK5FG5qppVHl2gltZu7ZY4hYi3Ndwbji15soH7e2dCQYA4LBYPif7U9zKV1nSD/9q7k6dqjfz277c7Xn+k3g+KL+l+8AYvsr7DT1xzUiN4sY2IhNFcdfJY4PrvpJphndqE5Djn/4rAg+ErnkRxs3eQDxhF3N8TE4s4TjufI2aF5D0g1DKxXxnOn3PPuMNRyfj89veO5qLcdNmawdJyQt/MgTHPdj2a7ZZL3CNeaiSYEL6b47VbHfH7INji7XttcbBOJ+zvWn0G8Sx5f0f/J7krO/zs4pOL4NpFx2H8Uf33QytuYq2nH8ThG8q4qHGI5PBB9gt5E/Ppg9mT9uxrZy7XHoYzHHA25WcjwTl4jnzeS4fILjqYnW2bdN+tHutcTxnChSIfiVyXndLp4YPSLHS/ONaY5X93/ue5Ll+Co71+OPj/71r/BPAHFATLuKZo6PTwH0ZnHq4Jai4R3A6IlbYtbGx6cCA3kn4Nr4+My+ifLF+Hii/BwfHwtstQqw7I8vmerU9Jl+Wu/keE0cIBPPCYGVjJO81x8X7+uD+cwcXwQ7c2zbHxetkcX+eORfy/54TRct6v/c96TSH6+003qes03wt8ar1eA20OxfM+tVGk51nmpm1a5XSYY7BI6Pr/sns15lBLF1wF2bGTvp8tF6lRNMdVbGx3O/bYsh7VulOD6XcTjVOdN1K+LLcWxXiP/kho2AmzYeXfCjp5MOB6+WmKGF+LiZM+jMK8M17/Uijsd9IsfHV3O8aEeoXYiPV9qJP8dtOd4GVZXRCYVy7bz/yK8fb8XWxjOcTj8467hLfqjPcbW+212DWLsOPVc+tX68Kcor16sEiwe8WIR792tCDWH55K39UDKaF41Pycc3slW4b/jen/PO7AL7q1vcewU5HlI33iTXj9t5S4fp7pywKfti+lPkeGkRjvhWzTxndf8L35PsLdFyO8nPcUOO73hSURxUGodx0PuDKmiXms+siQ+0aQnahONbP8+J0HoKbPY853WrwX09HD8vju/Ir3JDbpoTOXH/ztLh3TS/yjUT3H9cCI7fCscRQgjBcYQQQo30f/0BZGUrKYPiAAAAAElFTkSuQmCC)
