% Valores iniciales
a = [
    [6, 2, 1]
    [-1, 8, 2]
    [1, -1, 6]
];
b = [22, 30, 23];
n = length(a);
x0 = [0, 0, 0];
parIteraciones = 5;
parErrorNormalizado = -1;

% El resultado inicial son los valores iniciales.
resultado = x0;


% Variables temporales
numIteracion = 0;

while true

    % Aumentamos el valor para recordar que iteración estamos haciendo
    numIteracion = numIteracion + 1;

    % Obtenemos los anteriores resultados y creamos el arreglo para
    % contener los nuevos datos
    anteriorIteracion = resultado(height(resultado), :);
    siguienteIteracion = zeros(1, n);

    % Cpntador para conocer cuáles han cumplido el error normalizado de la parada
    errorNormalizadoCumplido = 0;

    for i = 1:n
        
        % Obtenemos los valores necesarios para la ecuación.
        aFila = a(i, :);
        aI = aFila(i);
        sumatoria = b(i);

        % Realizamos la sumatoria de los demás valores para simular el
        % despeje de la ecuación
        for j = 1:n
            if j ~= i
                sumatoria = sumatoria - (aFila(j) * anteriorIteracion(j));
            end
        end

        % Encontramos el valor dividiendo por el valor de ai
        xi = sumatoria / aI;
        siguienteIteracion(i) = xi;

        % Cálculamos el error normalizado y además, validamos que se haya
        % cumplido para sumarle al contador de que este lugar cumplió el
        % valor ingresado.
        errorNormalizado = abs((xi - anteriorIteracion(i)) / xi) * 100;
        if numIteracion > 1 && parErrorNormalizado >= 0 && errorNormalizado < parErrorNormalizado
            errorNormalizadoCumplido = errorNormalizadoCumplido + 1;
        end

    end

    % Guardamos en la siguiente fila los resultados encontrados
    resultado(height(resultado) + 1, :) = siguienteIteracion;

    % Método de parada por iteraciones
    if parIteraciones > 0 && numIteracion >= parIteraciones
       break;
    end

    % Método de parada por error normalizado, esto es porqué si la cantidad
    % de errores normalizados encontrados son iguales a la cantidad de
    % valores de X, quiere decir que lo cumplió y por lo tanto debe parar.
    if errorNormalizadoCumplido == n
        break
    end
    
end

disp(resultado)

