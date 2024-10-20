from pyspark.sql import SparkSession
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.clustering import KMeans

spark = SparkSession.builder.appName("CustomerSegmentation").enableHiveSupport().getOrCreate()

# Charger les données des clients depuis Hive
customers_df = spark.sql("SELECT annualincome, totalchildren FROM dim_customers")

# Assembler les features pour le clustering
assembler = VectorAssembler(inputCols=["annualincome", "totalchildren"], outputCol="features")
customer_features = assembler.transform(customers_df)

# Appliquer l'algorithme de clustering 
kmeans = KMeans(k=5, seed=1)
model = kmeans.fit(customer_features)

# Faire les prédictions de segments
predictions = model.transform(customer_features)
predictions.select("features", "prediction").write.csv("/path/to/output/segments_clients.csv")
